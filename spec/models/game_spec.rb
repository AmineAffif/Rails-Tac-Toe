require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '#initialize_board' do
    it 'initializes the board, current player, and status' do
      game = Game.new
      game.send(:initialize_board)
      expect(game.state).to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil])
      expect(game.current_player).to eq('X')
      expect(game.status).to eq('playing')
    end
  end

  describe '#finished?' do
    it 'returns true if status is won' do
      game = build(:game, status: 'won')
      expect(game.finished?).to eq(true)
    end

    it 'returns true if status is draw' do
      game = build(:game, status: 'draw')
      expect(game.finished?).to eq(true)
    end

    it 'returns false if still playing' do
      game = build(:game, status: 'playing')
      expect(game.finished?).to eq(false)
    end
  end
end
