# frozen_string_literal: true

require_relative 'pieces'
require_relative 'constants'

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

  def occupant_fen
    Constants::PIECE_CLASS_FEN_MAP[@occupant.color][@occupant.class]
  end
end
