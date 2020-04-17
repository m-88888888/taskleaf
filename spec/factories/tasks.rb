FactoryBot.define do
  factory :task do
    name { "テストを書く" }
    description { "RSpec&FactoriBotを準備する" }
    user
  end
end
