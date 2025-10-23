# frozen_string_literal: true

require_relative '../piece'
require_relative '../chess_constants'

# A knight chess piece
class Knight < Piece
  def initialize(color)
    super
    @icon = ChessConstants::PIECE_UNICODE_MAP[:knight]
  end

  def generate_adjacent_coords(algebraic_coords)
    generate_knight_adjacent_coords(algebraic_coords)
  end
end
