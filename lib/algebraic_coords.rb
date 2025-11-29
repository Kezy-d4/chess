# frozen_string_literal: true

require_relative 'constants'

# Algebraic coordinates corresponding to a square on a chess board
class AlgebraicCoords
  # @param file [String] the file coordinate between a and h
  # @param rank [Integer] the rank coordinate between 1 and 8
  def initialize(file, rank)
    @file = file
    @rank = rank
  end

  class << self
    # @param algebraic_coords_s [String] the in bounds algebraic coordinates
    def from_s(algebraic_coords_s)
      file = algebraic_coords_s[0]
      rank = algebraic_coords_s[1].to_i
      new(file, rank)
    end
  end

  def to_adjacency(file_adjustment, rank_adjustment)
    raise ArgumentError if file_adjustment.zero? && rank_adjustment.zero?
    raise ArgumentError unless adjustment_in_bounds?(file_adjustment, rank_adjustment)

    adjacent_file_idx = file_to_i + file_adjustment - 1
    adjacent_file = Constants::BOARD_FILES[adjacent_file_idx]
    adjacent_rank = @rank + rank_adjustment
    AlgebraicCoords.new(adjacent_file, adjacent_rank)
  end

  def to_northern_adjacencies
    to_directional_adjacencies(0, 1)
  end

  def to_eastern_adjacencies
    to_directional_adjacencies(1, 0)
  end

  def to_southern_adjacencies
    to_directional_adjacencies(0, -1)
  end

  def to_western_adjacencies
    to_directional_adjacencies(-1, 0)
  end

  def to_north_eastern_adjacencies
    to_directional_adjacencies(1, 1)
  end

  def to_south_eastern_adjacencies
    to_directional_adjacencies(1, -1)
  end

  def to_south_western_adjacencies
    to_directional_adjacencies(-1, -1)
  end

  def to_north_western_adjacencies
    to_directional_adjacencies(-1, 1)
  end

  def adjustment_in_bounds?(file_adjustment, rank_adjustment)
    file_adjustment_in_bounds?(file_adjustment) &&
      rank_adjustment_in_bounds?(rank_adjustment)
  end

  def file_to_i
    Constants::BOARD_FILES.index(@file) + 1
  end

  def to_s
    "#{@file}#{@rank}"
  end

  private

  def to_directional_adjacencies(file_adjustment, rank_adjustment)
    arr = []
    return arr unless adjustment_in_bounds?(file_adjustment, rank_adjustment)

    first_adjacency = to_adjacency(file_adjustment, rank_adjustment)
    arr << first_adjacency
    loop do
      break unless arr.last.adjustment_in_bounds?(file_adjustment, rank_adjustment)

      next_adjacency = arr.last.to_adjacency(file_adjustment, rank_adjustment)
      arr << next_adjacency
    end
    arr
  end

  def file_adjustment_in_bounds?(file_adjustment)
    file_post_adjustment = file_to_i + file_adjustment
    file_post_adjustment.between?(1, Constants::BOARD_FILES_LENGTH)
  end

  def rank_adjustment_in_bounds?(rank_adjustment)
    rank_post_adjustment = @rank + rank_adjustment
    rank_post_adjustment.between?(1, Constants::BOARD_RANKS_LENGTH)
  end
end
