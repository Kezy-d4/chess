# frozen_string_literal: true

# A square on a chess board
class Square
  def initialize(occupant = nil)
    @occupant = occupant
  end

  def occupied?
    @occupant != nil
  end
end
