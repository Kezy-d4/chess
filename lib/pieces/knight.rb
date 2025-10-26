# frozen_string_literal: true

require_relative '../piece'
require_relative '../chess_constants'

# A knight chess piece
class Knight < Piece
  def initialize(color)
    super
    @icon = ChessConstants::PIECE_UNICODE_MAP[:knight]
  end

  # The naming convention used here to describe the direction and location of
  # the knight's adjacent coordinates works as follows:
  # (direction)_one refers to the left-most adjacent coordinates in that direction;
  # (direction)_two refers to the right-most adjacent coordinates in that direction.
  def generate_adjacent_coords(algebraic_coords)
    {
      north_western_two: adjust_algebraic_coords(algebraic_coords, -1, 2),
      north_western_one: adjust_algebraic_coords(algebraic_coords, -2, 1),
      north_eastern_one: adjust_algebraic_coords(algebraic_coords, 1, 2),
      north_eastern_two: adjust_algebraic_coords(algebraic_coords, 2, 1),
      south_eastern_one: adjust_algebraic_coords(algebraic_coords, 1, -2),
      south_eastern_two: adjust_algebraic_coords(algebraic_coords, 2, -1),
      south_western_one: adjust_algebraic_coords(algebraic_coords, -2, -1),
      south_western_two: adjust_algebraic_coords(algebraic_coords, -1, -2)
    }.select { |_direction, adjacent_coords| algebraic_coords_in_bounds?(adjacent_coords) }
  end

  def moves_stepwise?
    false
  end
end
