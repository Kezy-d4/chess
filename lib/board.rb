# frozen_string_literal: true

require_relative 'fen_parser'
require_relative 'constants'

# A chess board
class Board
  def initialize(squares)
    @squares = squares
  end

  class << self
    def from_fen_parser(fen_parser)
      squares = fen_parser.construct_squares
      new(squares)
    end
  end
end
