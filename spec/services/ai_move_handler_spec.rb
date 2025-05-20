require 'rails_helper'

RSpec.describe AiMoveHandler do
  let(:game) { create(:game, against_ai: true) }
  let(:handler) { described_class.new(game) }

  describe "#call" do
    it "returns false if game is not against AI" do
      game.update(against_ai: false)
      expect(handler.call).to eq(false)
    end

    it "returns false if it's not AI's turn" do
      game.update(current_player: "X")
      expect(handler.call).to eq(false)
    end

    it "returns false if game is finished" do
      game.update(status: "won")
      expect(handler.call).to eq(false)
    end

    it "makes a move when conditions are met" do
      game.update(current_player: "O")
      expect { handler.call }.to change { game.state.compact.count }.by(1)
    end
  end
end 