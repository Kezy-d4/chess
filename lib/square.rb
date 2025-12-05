# frozen_string_literal: true

require_relative 'constants'

# A square on a chess board
class Square
  # @param algebraic_coords [String] the algebraic coordinates
  # @param occupant [Piece, nil] the occupying piece or nil
  def initialize(algebraic_coords, occupant = nil)
    @algebraic_coords = algebraic_coords
    @occupant = occupant
  end

  def to_s
    "<#{self.class}>: [" \
      "@algebraic_coords: #{@algebraic_coords}, " \
      "@occupant: #{@occupant}]"
  end
end
