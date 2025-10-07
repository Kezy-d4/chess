# frozen_string_literal: true

require_relative 'constants'

# Mixin to parse coordinates representing a square on a chessboard
module CoordsParsing
  def board_file_coord(coords)
    coords[0]
  end

  def board_rank_coord(coords)
    coords[1]
  end

  def algebraic_to_numeric_coords(algebraic_coords)
    numeric_board_file_coord =
      Constants::BOARD_FILE_NUMBER_MAP[board_file_coord(algebraic_coords)]
    "#{numeric_board_file_coord}#{board_rank_coord(algebraic_coords)}"
  end

  def numeric_to_algebraic_coords(numeric_coords)
    alphabetic_board_file_coord =
      Constants::NUMBER_BOARD_FILE_MAP[board_file_coord(numeric_coords)]
    "#{alphabetic_board_file_coord}#{board_rank_coord(numeric_coords)}"
  end
end
