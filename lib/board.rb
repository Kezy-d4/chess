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
      squares = fen_parser.construct_piece_placement_with_squares
      new(squares)
    end
  end

  def access_square(algebraic_coords)
    coords = parse_algebraic_coords(algebraic_coords)
    @squares[coords[:rank_key]][coords[:file_idx]]
  end

  private

  def parse_algebraic_coords(algebraic_coords)
    rank_key = algebraic_coords[-1].to_i
    file_coord = algebraic_coords[0]
    file_idx = ('a'..'z').to_a.index(file_coord)
    { rank_key: rank_key, file_idx: file_idx }
  end
end
