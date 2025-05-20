FactoryBot.define do
  factory :game do
    state { Array.new(9, nil) }
    current_player { "X" }
    status { "playing" }
  end
end
