# frozen_string_literal: true

require_relative '../piece'

# A queen chess piece
class Queen < Piece
  # n = north
  # e = east
  # s = south
  # w = west

  # rubocop: disable Metrics/MethodLength
  def generate_adjacent_coords
    a_c = AlgebraicCoords.from_s(@algebraic_coords)
    adjacencies = {
      n: a_c.to_northern_adjacencies,
      e: a_c.to_eastern_adjacencies,
      s: a_c.to_southern_adjacencies,
      w: a_c.to_western_adjacencies,
      n_e: a_c.to_north_eastern_adjacencies,
      s_e: a_c.to_south_eastern_adjacencies,
      s_w: a_c.to_south_western_adjacencies,
      n_w: a_c.to_north_western_adjacencies
    }
    adjacencies.delete_if { |_direction, arr| arr.empty? }
    adjacencies.transform_values { |arr| arr.map(&:to_s) }
  end
  # rubocop: enable all
end
