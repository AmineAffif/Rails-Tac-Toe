class CreateGames < ActiveRecord::Migration[7.2]
  def change
    create_table :games do |t|
      t.jsonb :state
      t.string :current_player
      t.string :status
      t.string :winner

      t.timestamps
    end
  end
end
