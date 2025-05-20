FactoryBot.define do
  factory :game do
    state { Array.new(9, nil) }
    current_player { "X" }
    status { "playing" }
    winner { nil }
    association :player_x, factory: :user
    association :player_o, factory: :user
    against_ai { false }
  end
end
