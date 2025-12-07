# frozen_string_literal: true

require_relative 'algebraic_coords'
require_relative 'constants'

# A superclass to each of the chess pieces
class Piece
  attr_reader :algebraic_coords, :color, :total_moves

  # @param algebraic_coords [String] the algebraic coordinates
  # @param color [Symbol] the color
  # @param total_moves [Integer] the total moves
  def initialize(algebraic_coords, color, total_moves = 0)
    @algebraic_coords = algebraic_coords
    @color = color
    @total_moves = total_moves
  end

  def white?
    @color == :white
  end

  def black?
    @color == :black
  end

  def update_algebraic_coords(new_algebraic_coords)
    @algebraic_coords = new_algebraic_coords
  end

  def increment_total_moves
    @total_moves += 1
  end

  def moved?
    @total_moves.positive?
  end

  def unmoved?
    @total_moves.zero?
  end

  def to_s
    "<#{self.class}>: [" \
      "@algebraic_coords: #{@algebraic_coords}, " \
      "@color: #{@color}, " \
      "@total_moves: #{@total_moves}]"
  end
end
