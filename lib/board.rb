# frozen_string_literal: true

require_relative 'fen_parser'
require_relative 'chess_constants'

# A chess board
class Board
  extend FenParser

  def initialize(squares)
    @squares = squares
  end

  class << self
    def from_fen(fen)

    end

    def generate_algebraic_coords
      ChessConstants::BOARD_RANKS.to_a.reverse.each_with_object([]) do |rank, arr|
        ChessConstants::BOARD_FILES.each { |file| arr << "#{file}#{rank}" }
      end
    end
  end
end
