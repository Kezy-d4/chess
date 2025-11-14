# frozen_string_literal: true

require_relative 'constants'

# In the context of a chess board, generates the in bounds algebraic coordinates
# adjacent to any given algebraic coordinates in stepwise order
module AdjacentCoordsGenerator
  def generate_northern_coords(algebraic_coords)
    generate_adjacent_coords(algebraic_coords, 0, 1)
  end

  def generate_north_eastern_coords(algebraic_coords)
    generate_adjacent_coords(algebraic_coords, 1, 1)
  end

  def generate_eastern_coords(algebraic_coords)
    generate_adjacent_coords(algebraic_coords, 1, 0)
  end

  def generate_south_eastern_coords(algebraic_coords)
    generate_adjacent_coords(algebraic_coords, 1, -1)
  end

  def generate_southern_coords(algebraic_coords)
    generate_adjacent_coords(algebraic_coords, 0, -1)
  end

  def generate_south_western_coords(algebraic_coords)
    generate_adjacent_coords(algebraic_coords, -1, -1)
  end

  def generate_western_coords(algebraic_coords)
    generate_adjacent_coords(algebraic_coords, -1, 0)
  end

  def generate_north_western_coords(algebraic_coords)
    generate_adjacent_coords(algebraic_coords, -1, 1)
  end

  private

  def generate_adjacent_coords(algebraic_coords, file_deviation, rank_deviation)
    numeric_coords = convert_algebraic_coords_to_numeric(algebraic_coords)
    arr = []
    loop do
      numeric_coords = adjust_numeric_coords(numeric_coords, file_deviation, rank_deviation)
      break unless numeric_coords_in_bounds?(numeric_coords)

      arr << convert_numeric_coords_to_algebraic(numeric_coords)
    end
    arr
  end

  def convert_algebraic_coords_to_numeric(algebraic_coords)
    file_coord = algebraic_coords[0]
    rank_coord = algebraic_coords[-1]
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
