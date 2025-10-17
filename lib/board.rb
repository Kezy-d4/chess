# frozen_string_literal: true

require_relative 'board_deserialization'
require_relative 'chess_constants'

# A chess board
class Board
  include BoardDeserialization

  def initialize(fen)
    @squares = deserialize_board(fen)
  end
end

# Test script

counter = 0
fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
board = Board.new(fen)
board.instance_variable_get(:@squares).each do |coords, square|
  print "#{coords}:"
  p square
  counter += 1
  if counter == ChessConstants::BOARD_FILES.to_a.length
    puts
    counter = 0
  end
end
