# frozen_string_literal: true

require_relative '../piece'
require_relative '../chess_constants'

# A bishop chess piece
class Bishop < Piece
  def initialize(color)
    super
    @icon = ChessConstants::PIECE_ICON_MAP[:bishop]
  end
end
