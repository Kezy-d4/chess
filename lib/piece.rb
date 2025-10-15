# frozen_string_literal: true

require_relative 'chess_constants'

# Parent to each of the chess pieces
class Piece
  def initialize(color)
    @color = color
  end
end
