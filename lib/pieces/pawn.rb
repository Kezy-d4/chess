# frozen_string_literal: true

require_relative '../piece'

# A pawn chess piece
class Pawn < Piece
  def initialize(algebraic_coords, color, total_moves)
    super
    @material_value = 1
  end
end
