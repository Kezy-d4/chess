# frozen_string_literal: true

require_relative '../piece'

# A bishop chess piece
class Bishop < Piece
  def initialize(algebraic_coords, color, total_moves)
    super
    @material_value = 3
  end
end
