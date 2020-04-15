class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    # 送信されたメアドでユーザーを探す
    user = User.find_by(email: session_params[:email])

    # パスワードの認証
    # ぼっち演算子（&.）とは、レシーバがnilの場合にnilを返す演算子
    # ここではuserがnilならばauthenticateメソッドを呼ばずにnilを返す
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "ログインしました。"
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "ログアウトしました。"
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
