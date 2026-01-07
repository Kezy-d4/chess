# frozen_string_literal: true

module Chess
  # A king chess piece
  class King < Piece
    # Wrap each value in an array to maintain a common interface with the other
    # pieces.
    # rubocop:disable Metrics/AbcSize
    def generate_adjacent_movement_coords(algebraic_coords)
      {
        north: [algebraic_coords.to_northern_adjacencies.first],
        east: [algebraic_coords.to_eastern_adjacencies.first],
        south: [algebraic_coords.to_southern_adjacencies.first],
        west: [algebraic_coords.to_western_adjacencies.first],
        north_east: [algebraic_coords.to_north_eastern_adjacencies.first],
        south_east: [algebraic_coords.to_south_eastern_adjacencies.first],
        south_west: [algebraic_coords.to_south_western_adjacencies.first],
        north_west: [algebraic_coords.to_north_western_adjacencies.first]
      }.delete_if { |_direction, arr| arr.compact.empty? }
    end
    # rubocop: enable all

    # Define #generate_adjacent_capture_coords to maintain a common interface with
    # Pawn and the other pieces.
    def generate_adjacent_capture_coords(algebraic_coords)
      generate_adjacent_movement_coords(algebraic_coords)
    end
  end
end
