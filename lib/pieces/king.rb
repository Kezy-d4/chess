# frozen_string_literal: true

require_relative '../piece'

# A king chess piece
class King < Piece
  def initialize(owner, color)
    super
    @icon = Constants::PIECE_UNICODE_ICON_MAP[:king]
  end
end
