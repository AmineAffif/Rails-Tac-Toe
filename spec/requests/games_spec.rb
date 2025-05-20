require 'rails_helper'

RSpec.describe "Games", type: :request do
  let(:user) { create(:user) }

  describe "POST /games" do
    context "when user is logged in" do
      before { post session_path, params: { email: user.email, password: "password" } }

      it "creates a game with the current user as player_x and against_ai true" do
        expect {
          post games_path
        }.to change(Game, :count).by(1)
        game = Game.last
        expect(game.player_x).to eq(user)
        expect(game.player_o).to be_nil
        expect(game.against_ai).to eq(true)
      end
    end

    context "when user is not logged in" do
      it "does not create a game and redirects to login" do
        expect {
          post games_path
        }.not_to change(Game, :count)
        expect(response).to redirect_to(new_session_path).or have_http_status(:found)
      end
    end
  end

  describe "User flow (integration)" do
    it "allows a user to sign up, login, create a game, and be player_x" do
      # Sign up
      post users_path, params: { user: { email: "integration@example.com", password: "password", password_confirmation: "password" } }
      expect(response).to redirect_to(new_session_path)
      # Login
      post session_path, params: { email: "integration@example.com", password: "password" }
      expect(session[:user_id]).to eq(User.find_by(email: "integration@example.com").id)
      # Create game
      expect {
        post games_path
      }.to change(Game, :count).by(1)
      game = Game.last
      expect(game.player_x.email).to eq("integration@example.com")
    end

    it "plays against AI until a player joins" do
      # Login
      post session_path, params: { email: user.email, password: "password" }
      # Create game
      post games_path
      game = Game.last
      
      # Make a move as player X
      post move_game_path(game, index: 0)
      game.reload
      
      # AI should have made a move
      expect(game.state.compact.count).to eq(2)
      expect(game.current_player).to eq("X")
      
      # Another user joins
      other_user = create(:user)
      post session_path, params: { email: other_user.email, password: "password" }
      get game_path(game)
      
      # Game should no longer be against AI
      game.reload
      expect(game.against_ai).to eq(false)
      expect(game.player_o).to eq(other_user)
    end
  end

  describe "Access control" do
    let(:other_user) { create(:user) }
    let(:game) { create(:game, player_x: user, player_o: nil) }

    it "denies access to show for non-players" do
      post session_path, params: { email: other_user.email, password: "password" }
      get game_path(game)
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("Access denied")
    end

    it "denies access to move for non-players" do
      post session_path, params: { email: other_user.email, password: "password" }
      post move_game_path(game, index: 0)
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("Access denied")
    end
  end
end 