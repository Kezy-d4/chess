# frozen_string_literal: true

require_relative 'fen_parser'
require_relative 'constants'

# A chess board
class Board
  def initialize(squares)
    @squares = squares
    @selected_square = nil
    @source_square = nil
    @destination_square = nil
  end

  class << self
    def from_fen_parser(fen_parser)
      squares = fen_parser.construct_piece_placement_with_squares
      new(squares)
    end
  end

  def access_square(algebraic_coords)
    coords = parse_algebraic_coords(algebraic_coords)
    @squares[coords[:rank_key]][coords[:file_idx]]
  end

  def update_selected_square(selected_square)
    @selected_square = selected_square
  end

  def reset_selected_square
    @selected_square = nil
  end

  def update_source_and_destination_squares(source_square, destination_square)
    @source_square = source_square
    @destination_square = destination_square
  end

  def reset_source_and_destination_squares
    @source_square = nil
    @destination_square = nil
  end

  private

  def parse_algebraic_coords(algebraic_coords)
    rank_key = algebraic_coords[-1].to_i
    file_coord = algebraic_coords[0]
    file_idx = ('a'..'z').to_a.index(file_coord)
    { rank_key: rank_key, file_idx: file_idx }
  end
end
