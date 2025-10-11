# frozen_string_literal: true

require_relative 'constants'
require_relative 'square'

# A rank on a chessboard
class BoardRank
  def initialize(data = nil)
    @data = data.nil? ? BoardRank.generate_empty_board_rank : data
  end

  class << self
    # untested
    def generate_empty_board_rank
      Array.new(Constants::BOARD_FILES.to_a.length) { Square.new }
    end
  end

  def access_square(square_index)
    @data[square_index]
  end
end
