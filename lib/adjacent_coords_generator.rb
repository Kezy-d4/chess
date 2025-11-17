# frozen_string_literal: true

require_relative 'constants'

# In the context of a chess board, generates the in bounds algebraic coordinates
# adjacent to any given algebraic coordinates in stepwise order
class AdjacentCoordsGenerator
  def initialize(algebraic_coords)
    @algebraic_coords = algebraic_coords
  end

  def generate_northern_coords
    generate_adjacent_coords(0, 1)
  end

  def generate_north_eastern_coords
    generate_adjacent_coords(1, 1)
  end

  def generate_eastern_coords
    generate_adjacent_coords(1, 0)
  end

  def generate_south_eastern_coords
    generate_adjacent_coords(1, -1)
  end

  def generate_southern_coords
    generate_adjacent_coords(0, -1)
  end

  def generate_south_western_coords
    generate_adjacent_coords(-1, -1)
  end

  def generate_western_coords
    generate_adjacent_coords(-1, 0)
  end

  def generate_north_western_coords
    generate_adjacent_coords(-1, 1)
  end

  # rubocop:disable Metrics/MethodLength
  def generate_knight_adjacent_coords
    numeric_coords = convert_algebraic_coords_to_numeric
    # The keys in this hash adhere to the following naming convention:
    # <direction>one: the leftmost coordinate in the given direction
    # <direction>two: the rightmost coordinate in the given direction
    hash = {
      north_east_one: adjust_numeric_coords(numeric_coords, 1, 2),
      north_east_two: adjust_numeric_coords(numeric_coords, 2, 1),
      south_east_one: adjust_numeric_coords(numeric_coords, 1, -2),
      south_east_two: adjust_numeric_coords(numeric_coords, 2, -1),
      south_west_one: adjust_numeric_coords(numeric_coords, -2, -1),
      south_west_two: adjust_numeric_coords(numeric_coords, -1, -2),
      north_west_one: adjust_numeric_coords(numeric_coords, -2, 1),
      north_west_two: adjust_numeric_coords(numeric_coords, -1, 2)
    }
    hash.delete_if { |_direction, numeric_coords| !numeric_coords_in_bounds?(numeric_coords) }
    hash.transform_values { |numeric_coords| convert_numeric_coords_to_algebraic(numeric_coords) }
  end
  # rubocop:enable all

  private

  def generate_adjacent_coords(file_deviation, rank_deviation)
    numeric_coords = convert_algebraic_coords_to_numeric
    arr = []
    loop do
      numeric_coords = adjust_numeric_coords(numeric_coords, file_deviation, rank_deviation)
      break unless numeric_coords_in_bounds?(numeric_coords)

      arr << convert_numeric_coords_to_algebraic(numeric_coords)
    end
    arr
  end

  def convert_algebraic_coords_to_numeric
    file_coord = @algebraic_coords[0]
    rank_coord = @algebraic_coords[-1]
    file_idx = ('a'..'z').to_a.index(file_coord).to_s
    "#{file_idx} #{rank_coord}"
  end

  def convert_numeric_coords_to_algebraic(numeric_coords)
    numeric_coords = numeric_coords.split
    file_idx = numeric_coords[0]
    rank_coord = numeric_coords[-1]
    file_coord = ('a'..'z').to_a[file_idx.to_i]
    "#{file_coord}#{rank_coord}"
  end

  def adjust_numeric_coords(numeric_coords, file_deviation, rank_deviation)
    numeric_coords = numeric_coords.split
    new_file_idx = (numeric_coords[0].to_i + file_deviation).to_s
    new_rank_coord = (numeric_coords[-1].to_i + rank_deviation).to_s
    "#{new_file_idx} #{new_rank_coord}"
  end

  def numeric_coords_in_bounds?(numeric_coords)
    numeric_coords = numeric_coords.split
    file_idx = numeric_coords[0]
    rank_coord = numeric_coords[-1]
    file_idx.to_i.between?(0, Constants::NUMBER_OF_BOARD_FILES - 1) &&
      rank_coord.to_i.between?(1, Constants::NUMBER_OF_BOARD_RANKS)
  end
end
