# frozen_string_literal: true

require_relative '../piece'

# A bishop chess piece
class Bishop < Piece
  def initialize(owner, color)
    super
    @icon = Constants::PIECE_UNICODE_ICON_MAP[:bishop]
  end
end
