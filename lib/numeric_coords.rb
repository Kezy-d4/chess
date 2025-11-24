# frozen_string_literal: true

require_relative 'constants'

# Numeric coordinates corresponding to a square or a piece on a chess board
class NumericCoords
  # @param file [Integer] the file coordinate
  # @param rank [Integer] the rank coordinate
  def initialize(file, rank)
    @file = file
    @rank = rank
  end

  def format
    { file: @file, rank: @rank }
  end

  def translate_to_algebraic
    algebraic_file = Constants::BOARD_FILES.to_a[@file - 1]
    { file: algebraic_file, rank: @rank }
  end

  def adjust(file_adjustment, rank_adjustment)
    @file += file_adjustment
    @rank += rank_adjustment
  end

  def in_bounds?
    file_in_bounds?(@file) && rank_in_bounds?(@rank)
  end

  private

  def file_in_bounds?(file)
    file.between?(1, Constants::BOARD_FILES_LENGTH)
  end

  def rank_in_bounds?(rank)
    rank.between?(1, Constants::BOARD_RANKS_LENGTH)
  end

  def generate_adjacencies(file_adjustment, rank_adjustment); end
end
