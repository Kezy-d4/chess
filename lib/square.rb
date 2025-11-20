# frozen_string_literal: true

require_relative 'constants'

# A square on a chess board
class Square
  def initialize(algebraic_coords, occupant = nil)
    @algebraic_coords = algebraic_coords
    @occupant = occupant
  end

  def determine_bg_color; end
end
