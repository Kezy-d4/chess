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
    {
      northern: generate_stepwise_northern_adjacent_coords(algebraic_coords),
      eastern: generate_stepwise_eastern_adjacent_coords(algebraic_coords),
      southern: generate_stepwise_southern_adjacent_coords(algebraic_coords),
      western: generate_stepwise_western_adjacent_coords(algebraic_coords),
      north_eastern: generate_stepwise_north_eastern_adjacent_coords(algebraic_coords),
      south_eastern: generate_stepwise_south_eastern_adjacent_coords(algebraic_coords),
      south_western: generate_stepwise_south_western_adjacent_coords(algebraic_coords),
      north_western: generate_stepwise_north_western_adjacent_coords(algebraic_coords)
    }.delete_if { |_direction, adjacent_coords| adjacent_coords.empty? }
  end

  def moves_stepwise?
    true
  end
end
