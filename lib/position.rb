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

    def algebraic_to_index_coords(algebraic_coords)
      board_rank_index = algebraic_coords[-1].to_i - 1
      board_file_index = Constants::BOARD_FILE_NUMBER_MAP[algebraic_coords[0]].to_i - 1
      [board_rank_index, board_file_index]
    end
  end

  def access_board_rank(board_rank_index)
    @data[board_rank_index]
  end

  def access_square(board_rank_index, square_index)
    @data[board_rank_index]&.access_square(square_index)
  end
end
