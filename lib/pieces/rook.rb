# frozen_string_literal: true

require_relative '../piece'
require_relative '../chess_constants'

# A rook chess piece
class Rook < Piece
  def initialize(color)
    super
    @icon = ChessConstants::PIECE_UNICODE_MAP[:rook]
  end
end
