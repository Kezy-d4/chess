# frozen_string_literal: true

require_relative '../piece'

# A knight chess piece
class Knight < Piece
  def initialize(algebraic_coords, color, total_moves)
    super
    @material_value = 3
  end
end
