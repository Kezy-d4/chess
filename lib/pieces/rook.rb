# frozen_string_literal: true

require_relative '../piece'
require_relative '../chess_constants'

# A rook chess piece
class Rook < Piece
  def initialize(color)
    super
    @icon = ChessConstants::PIECE_UNICODE_MAP[:rook]
  end

  def generate_adjacent_coords(algebraic_coords)
    [generate_stepwise_northern_adjacent_coords(algebraic_coords),
     generate_stepwise_southern_adjacent_coords(algebraic_coords),
     generate_stepwise_western_adjacent_coords(algebraic_coords),
     generate_stepwise_eastern_adjacent_coords(algebraic_coords)].flatten
  end
end
