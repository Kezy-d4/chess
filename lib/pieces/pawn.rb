# frozen_string_literal: true

require_relative '../piece'
require_relative '../chess_constants'

# A pawn chess piece
class Pawn < Piece
  def initialize(color)
    super
    @icon = ChessConstants::PIECE_UNICODE_MAP[:pawn]
  end
end
