# frozen_string_literal: true

module Chess
  # A pawn chess piece
  class Pawn < Piece
    using HashExtensions
    # Wrap values in an array where necessary to maintain a common interface
    # with the other pieces.

    def to_adjacent_movement_coords(coord)
      if white?
        to_white_adjacent_movement_coords(coord)
      elsif black?
        to_black_adjacent_movement_coords(coord)
      end
    end

    def to_adjacent_capture_coords(coord)
      if white?
        to_white_adjacent_capture_coords(coord)
      elsif black?
        to_black_adjacent_capture_coords(coord)
      end
    end

    private

    def to_white_adjacent_movement_coords(coord)
      if coord.rank == 2
        { north: coord.to_northern_adjacencies[0..1] }.delete_empty_arr_vals
      else
        { north: [coord.to_northern_adjacencies.first] }.delete_empty_arr_vals
      end
    end

    def to_black_adjacent_movement_coords(coord)
      if coord.rank == 7
        { south: coord.to_southern_adjacencies[0..1] }.delete_empty_arr_vals
      else
        { south: [coord.to_southern_adjacencies.first] }.delete_empty_arr_vals
      end
    end

    def to_white_adjacent_capture_coords(coord)
      {
        north_west: [coord.to_north_western_adjacencies.first],
        north_east: [coord.to_north_eastern_adjacencies.first]
      }.delete_empty_arr_vals
    end

    def to_black_adjacent_capture_coords(coord)
      {
        south_west: [coord.to_south_western_adjacencies.first],
        south_east: [coord.to_south_eastern_adjacencies.first]
      }.delete_empty_arr_vals
    end
  end
end
