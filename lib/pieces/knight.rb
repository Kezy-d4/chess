# frozen_string_literal: true

require_relative '../piece'

# A knight chess piece
class Knight < Piece
  # Wrap each value in an array to maintain a common interface with the other
  # pieces.
  def generate_adjacent_movement_coords(algebraic_coords)
    {
      north_east_left: [algebraic_coords.to_adjacency_string(1, 2)],
      north_east_right: [algebraic_coords.to_adjacency_string(2, 1)],
      south_east_left: [algebraic_coords.to_adjacency_string(1, -2)],
      south_east_right: [algebraic_coords.to_adjacency_string(2, -1)],
      south_west_left: [algebraic_coords.to_adjacency_string(-2, -1)],
      south_west_right: [algebraic_coords.to_adjacency_string(-1, -2)],
      north_west_left: [algebraic_coords.to_adjacency_string(-2, 1)],
      north_west_right: [algebraic_coords.to_adjacency_string(-1, 2)]
    }.delete_if { |_direction, arr| arr.compact.empty? }
  end

  # Define #generate_adjacent_capture_coords to maintain a common interface with
  # Pawn and the other pieces.
  def generate_adjacent_capture_coords(algebraic_coords)
    generate_adjacent_movement_coords(algebraic_coords)
  end
end
