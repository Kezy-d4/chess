# frozen_string_literal: true

require_relative '../piece'

# A knight chess piece
class Knight < Piece
  # n = north
  # e = east
  # s = south
  # w = west
  # l = left
  # r = right

  # While seemingly unnecessary, we wrap each value in an array to maintain a
  # common interface with the other pieces.
  # rubocop: disable Metrics/AbcSize, Metrics/CyclomaticComplexity
  # rubocop: disable Metrics/PerceivedComplexity, Metrics/MethodLength
  def generate_adjacent_coords
    a_c = AlgebraicCoords.from_s(@algebraic_coords)
    adjacencies = {
      n_e_l: [(a_c.to_adjacency(1, 2) if a_c.adjustment_in_bounds?(1, 2))],
      n_e_r: [(a_c.to_adjacency(2, 1) if a_c.adjustment_in_bounds?(2, 1))],
      s_e_l: [(a_c.to_adjacency(1, -2) if a_c.adjustment_in_bounds?(1, -2))],
      s_e_r: [(a_c.to_adjacency(2, -1) if a_c.adjustment_in_bounds?(2, -1))],
      s_w_l: [(a_c.to_adjacency(-2, -1) if a_c.adjustment_in_bounds?(-2, -1))],
      s_w_r: [(a_c.to_adjacency(-1, -2) if a_c.adjustment_in_bounds?(-1, -2))],
      n_w_l: [(a_c.to_adjacency(-2, 1) if a_c.adjustment_in_bounds?(-2, 1))],
      n_w_r: [(a_c.to_adjacency(-1, 2) if a_c.adjustment_in_bounds?(-1, 2))]
    }
    adjacencies.delete_if { |_direction, arr| arr.compact.empty? }
    adjacencies.transform_values { |arr| arr.map(&:to_s) }
  end
  # rubocop: enable all
end
