# frozen_string_literal: true

require_relative '../piece'
require_relative '../chess_constants'

# A queen chess piece
class Queen < Piece
  def initialize(color)
    super
    @icon = ChessConstants::PIECE_UNICODE_MAP[:queen]
  end

  def generate_adjacent_coords(algebraic_coords)
    [generate_stepwise_northern_adjacent_coords(algebraic_coords),
     generate_stepwise_southern_adjacent_coords(algebraic_coords),
     generate_stepwise_western_adjacent_coords(algebraic_coords),
     generate_stepwise_eastern_adjacent_coords(algebraic_coords),
     generate_stepwise_north_western_adjacent_coords(algebraic_coords),
     generate_stepwise_north_eastern_adjacent_coords(algebraic_coords),
     generate_stepwise_south_western_adjacent_coords(algebraic_coords),
     generate_stepwise_south_eastern_adjacent_coords(algebraic_coords)].flatten
  end
end
