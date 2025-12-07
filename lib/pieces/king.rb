# frozen_string_literal: true

require_relative '../piece'

# A king chess piece
class King < Piece
  # n = north
  # e = east
  # s = south
  # w = west

  # While seemingly unnecessary, we wrap each value in an array to maintain a
  # common interface with the other pieces.
  # rubocop: disable Metrics/AbcSize, Metrics/MethodLength
  def generate_adjacent_coords
    a_c = AlgebraicCoords.from_s(@algebraic_coords)
    adjacencies = {
      n: [a_c.to_northern_adjacencies.first],
      e: [a_c.to_eastern_adjacencies.first],
      s: [a_c.to_southern_adjacencies.first],
      w: [a_c.to_western_adjacencies.first],
      n_e: [a_c.to_north_eastern_adjacencies.first],
      s_e: [a_c.to_south_eastern_adjacencies.first],
      s_w: [a_c.to_south_western_adjacencies.first],
      n_w: [a_c.to_north_western_adjacencies.first]
    }
    adjacencies.delete_if { |_direction, arr| arr.compact.empty? }
    adjacencies.transform_values { |arr| arr.map(&:to_s) }
  end
  # rubocop: enable all
end
