# frozen_string_literal: true

require_relative 'chess_constants'

# A mixin to dynamically generate the algebraic coordinates adjacent to any
# given algebraic coordinates on a chess board
module AdjacentCoordsGeneration
  def generate_stepwise_northern_adjacent_coords(algebraic_coords)
    generate_stepwise_adjacent_coords(algebraic_coords, 0, 1)
  end

  private

  def generate_stepwise_adjacent_coords(algebraic_coords, board_file_deviation, board_rank_deviation)
    arr = []
    loop do
      algebraic_coords = adjust_algebraic_coords(algebraic_coords, board_file_deviation, board_rank_deviation)
      break unless algebraic_coords_in_bounds?(algebraic_coords)

      arr << algebraic_coords
    end
    arr
  end

  def adjust_algebraic_coords(algebraic_coords, board_file_deviation, board_rank_deviation)
    numeric_coords = translate_algebraic_to_numeric(algebraic_coords)
    board_file_coord = parse_board_file_coord(numeric_coords)
    board_rank_coord = parse_board_rank_coord(numeric_coords)
    new_board_file_coord = (board_file_coord.to_i + board_file_deviation).to_s
    new_board_rank_coord = (board_rank_coord.to_i + board_rank_deviation).to_s
    updated_numeric_coords = "#{new_board_file_coord}#{new_board_rank_coord}"
    translate_numeric_to_algebraic(updated_numeric_coords)
  end

  def algebraic_coords_in_bounds?(algebraic_coords)
    board_file_coord = parse_board_file_coord(algebraic_coords)
    board_rank_coord = parse_board_rank_coord(algebraic_coords)
    ChessConstants::BOARD_FILES.include?(board_file_coord) &&
      ChessConstants::BOARD_RANKS.include?(board_rank_coord.to_i)
  end

  def translate_algebraic_to_numeric(algebraic_coords)
    board_file_coord = parse_board_file_coord(algebraic_coords)
    new_board_file_coord = ChessConstants::BOARD_FILE_NUMBER_MAP[board_file_coord]
    algebraic_coords.sub(board_file_coord, new_board_file_coord)
  end

  def translate_numeric_to_algebraic(numeric_coords)
    board_file_coord = parse_board_file_coord(numeric_coords)
    new_board_file_coord = ChessConstants::NUMBER_BOARD_FILE_MAP[board_file_coord]
    numeric_coords.sub(board_file_coord, new_board_file_coord)
  end

  def parse_board_file_coord(coords)
    coords[0]
  end

  def parse_board_rank_coord(coords)
    coords[1]
  end
end
