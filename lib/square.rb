# frozen_string_literal: true

require_relative 'pieces'

# A square on a chessboard
class Square
  attr_reader :occupant

  def initialize(occupant = nil)
    @occupant = occupant
  end

  def empty?
    @occupant.nil?
  end

  def occupied?
    @occupant.is_a?(Piece)
  end
end
