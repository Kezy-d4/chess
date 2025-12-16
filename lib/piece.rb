# frozen_string_literal: true

require_relative 'constants'

# A superclass to each of the chess pieces
class Piece
  # @param color [Symbol] the color
  # @param total_moves [Integer] the total moves
  def initialize(color, total_moves = 0)
    @color = color
    @total_moves = total_moves
  end

  def white?
    @color == :white
  end

  def black?
    @color == :black
  end

  def moved?
    @total_moves.positive?
  end

  def moved_once?
    @total_moves == 1
  end

  def moved_more_than_once?
    @total_moves > 1
  end

  def unmoved?
    @total_moves.zero?
  end

  def to_s
    if unmoved?
      "The #{self.class} is #{@color} and has not moved."
    elsif moved_once?
      "The #{self.class} is #{@color} and has moved #{@total_moves} time."
    elsif moved_more_than_once?
      "The #{self.class} is #{@color} and has moved #{@total_moves} times."
    end
  end
end
