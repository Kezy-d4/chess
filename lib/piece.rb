# frozen_string_literal: true

require_relative 'constants'

# Superclass to each of the chess pieces
class Piece
  def initialize(algebraic_coords, color, total_moves)
    @algebraic_coords = algebraic_coords
    @color = color
    @total_moves = total_moves
  end

  def increment_total_moves
    @total_moves += 1
  end

  def moved?
    @total_moves.positive?
  end

  def white?
    @color == :white
  end

  def black?
    @color == :black
  end
end
