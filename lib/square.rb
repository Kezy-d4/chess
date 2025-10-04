# frozen_string_literal: true

# A square on a chessboard
class Square
  attr_reader :occupant

  def initialize(occupant = nil)
    @occupant = occupant
  end
end
