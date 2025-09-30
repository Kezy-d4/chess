# frozen_string_literal: true

require_relative '../piece'

# A rook chess piece
class Rook < Piece
  def initialize(owner, color)
    super
    @icon = Constants::PIECE_UNICODE_ICON_MAP[:rook]
  end
end
