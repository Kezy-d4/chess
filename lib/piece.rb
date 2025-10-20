# frozen_string_literal: true

require_relative 'chess_constants'

# Parent to each of the chess pieces
class Piece
  attr_reader :color, :icon

  def initialize(color)
    @color = color
  end
end
