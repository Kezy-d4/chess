# frozen_string_literal: true

require_relative 'constants'

# A square on a chess board
class Square
  attr_reader :algebraic_coords, :occupant

  # @param algebraic_coords [String] the algebraic coordinates
  # @param occupant [Piece, nil] the occupying piece or nil
  def initialize(algebraic_coords, occupant = nil)
    @algebraic_coords = algebraic_coords
    @occupant = occupant
  end

  def occupied?
    @occupant != nil
  end

  def unoccupied?
    @occupant.nil?
  end

  def update_occupant(new_occupant)
    @occupant = new_occupant
  end

  def remove_occupant
    occupant_to_remove = @occupant
    @occupant = nil
    occupant_to_remove
  end

  def to_s
    "<#{self.class}>: [" \
      "@algebraic_coords: #{@algebraic_coords}, " \
      "@occupant: #{@occupant}]"
  end
end
