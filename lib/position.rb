# frozen_string_literal: true

require_relative 'constants'
require_relative 'board_rank'

# A chess position
class Position
  def initialize(data = nil)
    @data = data.nil? ? Position.generate_empty_position : data
  end

  class << self
    # untested
    def generate_empty_position
      Array.new(Constants::BOARD_RANKS.to_a.length) { BoardRank.new }
    end
  end

  def access_board_rank(board_rank_index)
    @data[board_rank_index]
  end

  def access_square(board_rank_index, square_index)
    @data[board_rank_index]&.access_square(square_index)
  end
end
