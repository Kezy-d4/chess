# frozen_string_literal: true

require_relative 'constants'

# Superclass to each of the pieces
class Piece
  def initialize(color)
    @color = color
  end

  def white?
    @color == :white
  end

  def black?
    @color == :black
  end
end
