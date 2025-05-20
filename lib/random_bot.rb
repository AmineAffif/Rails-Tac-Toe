class RandomBot
  def self.pick_move(game)
    empty_indexes(game.state).sample
  end

  def self.empty_indexes(state)
    state.each_with_index.select { |val, _| val.nil? }.map(&:last)
  end
end
