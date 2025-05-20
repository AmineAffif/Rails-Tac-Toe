class User < ApplicationRecord
  has_secure_password

  has_many :games_as_x, class_name: 'Game', foreign_key: 'player_x_id', dependent: :nullify
  has_many :games_as_o, class_name: 'Game', foreign_key: 'player_o_id', dependent: :nullify

  validates :email, presence: true, uniqueness: true

  # Pour retrouver toutes les games d'un user
  def games
    Game.where('player_x_id = ? OR player_o_id = ?', id, id)
  end
end
