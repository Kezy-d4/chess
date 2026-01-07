# frozen_string_literal: true

module Chess
  # A queen chess piece
  class Queen < Piece
    def generate_adjacent_movement_coords(algebraic_coords)
      {
        north: algebraic_coords.to_northern_adjacencies,
        east: algebraic_coords.to_eastern_adjacencies,
        south: algebraic_coords.to_southern_adjacencies,
        west: algebraic_coords.to_western_adjacencies,
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
end
