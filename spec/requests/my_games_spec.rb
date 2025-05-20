require 'rails_helper'

RSpec.describe "MyGames", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before do
    # Crée des parties pour user et pour other_user
    create(:game, player_x: user)
    create(:game, player_o: user)
    create(:game, player_x: other_user)
  end

  describe "GET /my_games" do
    context "when user is logged in" do
      before { post session_path, params: { email: user.email, password: "password" } }

      it "shows only the games of the current user" do
        get my_games_path
        expect(response).to have_http_status(:success)
        user.games.each do |game|
          expect(response.body).to include(game.id.to_s)
        end
        other_user.games.each do |game|
          expect(response.body).not_to include(game.id.to_s)
        end
      end
    end

    context "when user is not logged in" do
      it "redirects to login" do
        get my_games_path
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end 