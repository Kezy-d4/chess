# frozen_string_literal: true

require_relative '../piece'

# A rook chess piece
class Rook < Piece
  # n = north
  # e = east
  # s = south
  # w = west

  def generate_adjacent_coords
    a_c = AlgebraicCoords.from_s(@algebraic_coords)
    adjacencies = {
      n: a_c.to_northern_adjacencies,
      s: a_c.to_southern_adjacencies,
      w: a_c.to_western_adjacencies,
      e: a_c.to_eastern_adjacencies
    }
    adjacencies.delete_if { |_direction, arr| arr.empty? }
    adjacencies.transform_values { |arr| arr.map(&:to_s) }
  end
end
