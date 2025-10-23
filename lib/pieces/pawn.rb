# frozen_string_literal: true

require_relative '../piece'
require_relative '../chess_constants'

# A pawn chess piece
class Pawn < Piece
  def initialize(color)
    super
    @icon = ChessConstants::PIECE_UNICODE_MAP[:pawn]
  end

  def generate_adjacent_coords(algebraic_coords)
    if white?
      [generate_stepwise_north_western_adjacent_coords(algebraic_coords).first,
       generate_stepwise_north_eastern_adjacent_coords(algebraic_coords).first].compact
    elsif black?
      [generate_stepwise_south_western_adjacent_coords(algebraic_coords).first,
       generate_stepwise_south_eastern_adjacent_coords(algebraic_coords).first].compact
    end
  end
end
