# frozen_string_literal: true

require_relative 'coords_parsing'
require_relative 'constants'

# CoordsProcessing is a mixin to process coordinates representing a square on a
# chessboard. Its primary responsibility is to generate the coordinates adjacent
# to any given algebraic coordinates.
module CoordsProcessing
  include CoordsParsing

  def vertical_adjacent_coords(algebraic_coords)
    Constants::BOARD_RANKS.to_a.each_with_object([]) do |board_rank, arr|
      next if board_rank.to_s == board_rank_coord(algebraic_coords)

      adjacent_coords = "#{board_file_coord(algebraic_coords)}#{board_rank}"
      arr << adjacent_coords
    end
  end

  def horizontal_adjacent_coords(algebraic_coords)
    Constants::BOARD_FILES.to_a.each_with_object([]) do |board_file, arr|
      next if board_file == board_file_coord(algebraic_coords)

      adjacent_coords = "#{board_file}#{board_rank_coord(algebraic_coords)}"
      arr << adjacent_coords
    end
  end

  def top_left_diagonal_adjacent_coords(algebraic_coords)
    diagonal_adjacent_coords(algebraic_coords, -1, 1)
  end

  def top_right_diagonal_adjacent_coords(algebraic_coords)
    diagonal_adjacent_coords(algebraic_coords, 1, 1)
  end

  def bottom_left_diagonal_adjacent_coords(algebraic_coords)
    diagonal_adjacent_coords(algebraic_coords, -1, -1)
  end

  def bottom_right_diagonal_adjacent_coords(algebraic_coords)
    diagonal_adjacent_coords(algebraic_coords, 1, -1)
  end

  def top_left_knight_adjacent_coords(algebraic_coords)
    [knight_adjacent_coords(algebraic_coords, -2, 1),
     knight_adjacent_coords(algebraic_coords, -1, 2)].compact
  end

  def top_right_knight_adjacent_coords(algebraic_coords)
    [knight_adjacent_coords(algebraic_coords, 2, 1),
     knight_adjacent_coords(algebraic_coords, 1, 2)].compact
  end

  def bottom_left_knight_adjacent_coords(algebraic_coords)
    [knight_adjacent_coords(algebraic_coords, -2, -1),
     knight_adjacent_coords(algebraic_coords, -1, -2)].compact
  end

  def bottom_right_knight_adjacent_coords(algebraic_coords)
    [knight_adjacent_coords(algebraic_coords, 2, -1),
     knight_adjacent_coords(algebraic_coords, 1, -2)].compact
  end

  def diagonal_adjacent_coords(algebraic_coords, board_file_deviation, board_rank_deviation)
    arr = []
    numeric_coords = algebraic_to_numeric_coords(algebraic_coords)
    loop do
      new_board_file_coord = board_file_coord(numeric_coords).to_i + board_file_deviation
      new_board_rank_coord = board_rank_coord(numeric_coords).to_i + board_rank_deviation
      numeric_coords = "#{new_board_file_coord}#{new_board_rank_coord}"
      break unless numeric_coords_in_bounds?(numeric_coords)

      arr << numeric_to_algebraic_coords(numeric_coords)
    end
    arr
  end

  def knight_adjacent_coords(algebraic_coords, board_file_deviation, board_rank_deviation)
    numeric_coords = algebraic_to_numeric_coords(algebraic_coords)
    new_board_file_coord = board_file_coord(numeric_coords).to_i + board_file_deviation
    new_board_rank_coord = board_rank_coord(numeric_coords).to_i + board_rank_deviation
    new_numeric_coords = "#{new_board_file_coord}#{new_board_rank_coord}"
    numeric_to_algebraic_coords(new_numeric_coords) if numeric_coords_in_bounds?(new_numeric_coords)
  end

  private :diagonal_adjacent_coords, :knight_adjacent_coords
end
