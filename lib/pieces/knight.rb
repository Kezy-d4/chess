# frozen_string_literal: true

require_relative '../piece'

# A knight chess piece
class Knight < Piece
  def initialize(owner, color)
    super
    @icon = Constants::PIECE_UNICODE_ICON_MAP[:knight]
  end
end
