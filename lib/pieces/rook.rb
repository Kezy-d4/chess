# frozen_string_literal: true

require_relative '../piece'

# A rook chess piece
class Rook < Piece
  def initialize(algebraic_coords, color, total_moves)
    super
    @material_value = 5
  end
end
