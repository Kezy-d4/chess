# frozen_string_literal: true

require_relative '../piece'

# A queen chess piece
class Queen < Piece
  def initialize(color)
    super
    @icon = Constants::PIECE_UNICODE_ICON_MAP[:queen]
  end
end
