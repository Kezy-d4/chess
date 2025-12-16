# frozen_string_literal: true

require_relative '../piece'

# A bishop chess piece
class Bishop < Piece
  def generate_adjacent_movement_coords(algebraic_coords)
    {
      north_east: algebraic_coords.to_north_eastern_adjacencies,
      south_east: algebraic_coords.to_south_eastern_adjacencies,
      south_west: algebraic_coords.to_south_western_adjacencies,
      north_west: algebraic_coords.to_north_western_adjacencies
    }.delete_if { |_direction, arr| arr.empty? }
  end

  # Define #generate_adjacent_capture_coords to maintain a common interface with
  # Pawn and the other pieces.
  def generate_adjacent_capture_coords(algebraic_coords)
    generate_adjacent_movement_coords(algebraic_coords)
  end
end
