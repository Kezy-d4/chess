# frozen_string_literal: true

require_relative '../piece'
require_relative '../chess_constants'

# A queen chess piece
class Queen < Piece
  def initialize(color)
    super
    @icon = ChessConstants::PIECE_UNICODE_MAP[:queen]
  end
end
