# frozen_string_literal: true

# A square on a chess board
class Square
  def initialize(occupant = nil)
    @occupant = occupant
  end

  def occupied?
    @occupant != nil
  end

  def update_occupant(new_occupant)
    @occupant = new_occupant
  end

  def remove_occupant
    @occupant = nil
  end
end
