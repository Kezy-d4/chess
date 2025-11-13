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
    occupant_to_remove = @occupant
    @occupant = nil
    occupant_to_remove
  end

  def occupant_is_white?
    return false unless occupied?

    @occupant.white?
  end

  def occupant_is_black?
    return false unless occupied?

    @occupant.black?
  end
end
