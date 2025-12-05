# frozen_string_literal: true

require_relative 'constants'

# A superclass to each of the chess pieces
class Piece
  # @param algebraic_coords [String] the algebraic coordinates
  # @param color [Symbol] the color
  # @param total_moves [Integer] the total moves
  def initialize(algebraic_coords, color, total_moves = 0)
    @algebraic_coords = algebraic_coords
    @color = color
    @total_moves = total_moves
  end

  def to_s
    "<#{self.class}>: [" \
      "@algebraic_coords: #{@algebraic_coords}, " \
      "@color: #{@color}, " \
      "@total_moves: #{@total_moves}]"
  end
end
