# frozen_string_literal: true

require_relative '../piece'

# A pawn chess piece
class Pawn < Piece
  # n = north
  # e = east
  # s = south
  # w = west

  # The pawn is the only chess piece which does not capture the same way that it
  # moves. It is also the only piece for which its color determines the
  # direction of its moves. It does not have a common interface with the other
  # pieces as we must distinguish between capture and movement adjacencies.
  # However, we still wrap values in an array where necessary to maintain as
  # much of a common interface as possible.

  def generate_adjacent_movement_coords
    adjacencies = {}
    if white?
      adjacencies = generate_white_adjacent_movement_coords
    elsif black?
      adjacencies = generate_black_adjacent_movement_coords
    end
    adjacencies.delete_if { |_direction, arr| arr.compact.empty? }
    adjacencies = adjacencies.transform_values { |arr| arr.map(&:to_s) } unless adjacencies.empty?
    adjacencies
  end

  def generate_adjacent_capture_coords
    adjacencies = {}
    if white?
      adjacencies = generate_white_adjacent_capture_coords
    elsif black?
      adjacencies = generate_black_adjacent_capture_coords
    end
    adjacencies.delete_if { |_direction, arr| arr.compact.empty? }
    adjacencies = adjacencies.transform_values { |arr| arr.map(&:to_s) } unless adjacencies.empty?
    adjacencies
  end

  private

  def generate_white_adjacent_movement_coords
    a_c = AlgebraicCoords.from_s(@algebraic_coords)
    adjacencies = {}
    if moved?
      adjacencies[:n] = [a_c.to_northern_adjacencies.first]
    elsif unmoved?
      adjacencies[:n] = a_c.to_northern_adjacencies[0..1]
    end
    adjacencies
  end

  def generate_black_adjacent_movement_coords
    a_c = AlgebraicCoords.from_s(@algebraic_coords)
    adjacencies = {}
    if moved?
      adjacencies[:s] = [a_c.to_southern_adjacencies.first]
    elsif unmoved?
      adjacencies[:s] = a_c.to_southern_adjacencies[0..1]
    end
    adjacencies
  end

  def generate_white_adjacent_capture_coords
    a_c = AlgebraicCoords.from_s(@algebraic_coords)
    { n_w: [a_c.to_north_western_adjacencies.first],
      n_e: [a_c.to_north_eastern_adjacencies.first] }
  end

  def generate_black_adjacent_capture_coords
    a_c = AlgebraicCoords.from_s(@algebraic_coords)
    { s_w: [a_c.to_south_western_adjacencies.first],
      s_e: [a_c.to_south_eastern_adjacencies.first] }
  end
end
