# frozen_string_literal: true

require_relative 'chess_constants'

# A square on a chess board
class Square
  attr_reader :occupant

  def initialize(occupant = nil)
    @occupant = occupant
  end

  def update_occupant(new_occupant)
    @occupant = new_occupant
  end

  def remove_occupant
    removed_occupant = @occupant
    @occupant = nil
    removed_occupant
  end

  def empty?
    @occupant.nil?
  end

  def occupied?
    @occupant != nil
  end
end
