# frozen_string_literal: true

require_relative '../piece'

# A pawn chess piece
class Pawn < Piece
  def initialize(owner, color)
    super
    @icon = Constants::PIECE_UNICODE_ICON_MAP[:pawn]
  end
end
