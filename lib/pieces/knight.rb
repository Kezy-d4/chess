# frozen_string_literal: true

require_relative '../piece'
require_relative '../chess_constants'

# A knight chess piece
class Knight < Piece
  def initialize(color)
    super
    @icon = ChessConstants::PIECE_UNICODE_MAP[:knight]
  end
end
