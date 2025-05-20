class AddPlayersAndAgainstAiToGames < ActiveRecord::Migration[7.2]
  def change
    add_column :games, :player_x_id, :integer
    add_column :games, :player_o_id, :integer
    add_column :games, :against_ai, :boolean
  end
end
