# frozen_string_literal: true

require_relative '../piece'
require_relative '../chess_constants'

# A king chess piece
class King < Piece
  def initialize(color)
    super
    @icon = ChessConstants::PIECE_ICON_MAP[:king]
  end
end
