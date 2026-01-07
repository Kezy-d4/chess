# frozen_string_literal: true

module Chess
  # A pawn chess piece
  class Pawn < Piece
    # Wrap values in an array where necessary to maintain a common interface with
    # the other pieces.

    def generate_adjacent_movement_coords(algebraic_coords)
      if white?
        generate_white_adjacent_movement_coords(algebraic_coords)
      elsif black?
        generate_black_adjacent_movement_coords(algebraic_coords)
      end
    end

    def generate_adjacent_capture_coords(algebraic_coords)
      if white?
        generate_white_adjacent_capture_coords(algebraic_coords)
      elsif black?
        generate_black_adjacent_capture_coords(algebraic_coords)
      end
    end

    private

    def generate_white_adjacent_movement_coords(algebraic_coords)
      hash = {}
      if unmoved?
        hash = { north: algebraic_coords.to_northern_adjacencies[0..1] }
      elsif moved?
        hash = { north: [algebraic_coords.to_northern_adjacencies.first] }
      end
      hash.delete_if { |_direction, arr| arr.compact.empty? }
    end

    def generate_black_adjacent_movement_coords(algebraic_coords)
      hash = {}
      if unmoved?
        hash = { south: algebraic_coords.to_southern_adjacencies[0..1] }
      elsif moved?
        hash = { south: [algebraic_coords.to_southern_adjacencies.first] }
      end
      hash.delete_if { |_direction, arr| arr.compact.empty? }
    end

    def generate_white_adjacent_capture_coords(algebraic_coords)
      {
        north_west: [algebraic_coords.to_north_western_adjacencies.first],
        north_east: [algebraic_coords.to_north_eastern_adjacencies.first]
      }.delete_if { |_direction, arr| arr.compact.empty? }
    end

    def generate_black_adjacent_capture_coords(algebraic_coords)
      {
        south_west: [algebraic_coords.to_south_western_adjacencies.first],
        south_east: [algebraic_coords.to_south_eastern_adjacencies.first]
      }.delete_if { |_direction, arr| arr.compact.empty? }
    end
  end
end
