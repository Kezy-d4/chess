# frozen_string_literal: true

require_relative '../piece'
require_relative '../chess_constants'

# A bishop chess piece
class Bishop < Piece
  def initialize(color)
    super
    @icon = ChessConstants::PIECE_UNICODE_MAP[:bishop]
  end

  def generate_adjacent_coords(algebraic_coords)
    [generate_stepwise_north_western_adjacent_coords(algebraic_coords),
     generate_stepwise_north_eastern_adjacent_coords(algebraic_coords),
     generate_stepwise_south_western_adjacent_coords(algebraic_coords),
     generate_stepwise_south_eastern_adjacent_coords(algebraic_coords)].flatten
  end
end
