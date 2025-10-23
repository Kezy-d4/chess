# frozen_string_literal: true

require_relative 'adjacent_coords_generation'
require_relative 'chess_constants'

# Parent to each of the chess pieces
class Piece
  include AdjacentCoordsGeneration

  attr_reader :color, :icon

  def initialize(color)
    @color = color
  end

  def black?
    @color == :black
  end

  def white?
    @color == :white
  end
end
