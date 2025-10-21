# frozen_string_literal: true

require_relative 'fen_parser'
require_relative 'square'
require_relative 'pieces'
require_relative 'chess_constants'

# A chess board
class Board
  extend FenParser

  def initialize(squares)
    @squares = squares
  end

  class << self
    def from_fen(fen)
      squares = construct_squares(fen)
      named_squares = Board.generate_algebraic_coords.each_with_object({}) do |coords, hash|
        squares.shift if squares.first == '/'
        hash[coords] = squares.shift
      end
      new(named_squares)
    end

    def generate_algebraic_coords
      ChessConstants::BOARD_RANKS.to_a.reverse.each_with_object([]) do |rank, arr|
        ChessConstants::BOARD_FILES.each { |file| arr << "#{file}#{rank}" }
      end
    end
  end

  def access_square(algebraic_coords)
    @squares[algebraic_coords]
  end

  def update_square_occupant(algebraic_coords, new_occupant)
    access_square(algebraic_coords).update_occupant(new_occupant)
  end
end
