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

  def access_square(algebraic_coords)
    rank_key = algebraic_coords[-1].to_i
    file_idx = ('a'..'z').to_a.index(algebraic_coords[0])
    @squares[rank_key][file_idx]
  end
end
