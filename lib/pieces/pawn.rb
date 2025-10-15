# frozen_string_literal: true

require_relative '../piece'
require_relative '../chess_constants'

# A pawn chess piece
class Pawn < Piece
  def initialize(color)
    super
    @icon = ChessConstants::PIECE_ICON_MAP[:pawn]
  end
end
