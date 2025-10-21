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
end

# Test script
system('clear')

fen = ChessConstants::DEFAULT_FEN
board = Board.from_fen(fen)
counter = 0
board.instance_variable_get(:@squares).each do |coords, square|
  print "#{coords}:"
  p square
  counter += 1
  if counter == ChessConstants::AMOUNT_OF_BOARD_FILES
    puts
    counter = 0
  end
end

gets
