# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Création de 5 utilisateurs
users = 5.times.map do |i|
  User.create!(email: "user#{i+1}@example.com", password: "password", password_confirmation: "password")
end

# Création de parties user vs user
3.times do
  Game.create!(
    player_x: users.sample,
    player_o: users.sample,
    against_ai: false,
    state: Array.new(9, nil),
    current_player: "X",
    status: "playing"
  )
end

# Création de parties user vs IA
2.times do
  Game.create!(
    player_x: users.sample,
    player_o: nil,
    against_ai: true,
    state: Array.new(9, nil),
    current_player: "X",
    status: "playing"
  )
end

puts "Seed completed: #{User.count} users, #{Game.count} games."
