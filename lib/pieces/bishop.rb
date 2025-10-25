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
    {
      north_eastern: generate_stepwise_north_eastern_adjacent_coords(algebraic_coords),
      south_eastern: generate_stepwise_south_eastern_adjacent_coords(algebraic_coords),
      south_western: generate_stepwise_south_western_adjacent_coords(algebraic_coords),
      north_western: generate_stepwise_north_western_adjacent_coords(algebraic_coords)
    }.delete_if { |_direction, adjacent_coords| adjacent_coords.empty? }
  end
end
