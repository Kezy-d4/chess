# frozen_string_literal: true

require_relative '../piece'

# A queen chess piece
class Queen < Piece
  def initialize(algebraic_coords, color, total_moves)
    super
    @material_value = 9
  end
end
