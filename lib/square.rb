# frozen_string_literal: true

require_relative 'constants'

# A square on a chess board
class Square
  attr_reader :occupant

  def initialize(algebraic_coords, occupant = nil)
    @algebraic_coords = algebraic_coords
    @occupant = occupant
  end

  def update_occupant(new_occupant)
    @occupant = new_occupant
  end

  def remove_occupant
    occupant_to_remove = @occupant
    @occupant = nil
    occupant_to_remove
  end

  def determine_bg_color
    rank_coord = @algebraic_coords[-1].to_i
    file_coord = ('a'..'z').to_a.index(@algebraic_coords[0]) + 1
    if (rank_coord.even? && file_coord.even?) || (rank_coord.odd? && file_coord.odd?)
      :black
    else
      :white
    end
  end
end
