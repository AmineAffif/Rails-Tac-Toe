require 'rails_helper'

RSpec.describe GameEngine do
  let(:game) { build(:game) }
  let(:engine) { described_class.new(game) }

  describe "#play_move" do
    it "plays a valid move" do
      expect { engine.play_move(0, "X") }.to change { game.state[0] }.from(nil).to("X")
    end

    it "rejects a move on an occupied cell" do
      game.state[0] = "O"
      expect(engine.play_move(0, "X")).to eq(false)
    end

    it "detects a win" do
      game.state = ["X", "X", nil, nil, nil, nil, nil, nil, nil]
      engine.play_move(2, "X")
      expect(game.status).to eq("won")
      expect(game.winner).to eq("X")
    end

    it "detects a draw" do
      game.state = ["X", "O", "X", "X", "O", "O", "O", "X", nil]
      engine.play_move(8, "X")
      expect(game.status).to eq("draw")
    end

    it "switches player after a move" do
      engine.play_move(0, "X")
      expect(game.current_player).to eq("O")
    end
  end

  describe "#winner?" do
    it "returns true if the player has won" do
      game.state = ["O", "O", "O", nil, nil, nil, nil, nil, nil]
      expect(engine.winner?("O")).to eq(true)
    end
  end

  describe "#draw?" do
    it "returns true if all cells are filled" do
      game.state = Array.new(9, "X")
      expect(engine.draw?).to eq(true)
    end
  end
end
