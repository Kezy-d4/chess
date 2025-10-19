# frozen_string_literal: true

require_relative 'fen_parser'
require_relative 'square'
require_relative 'chess_constants'

# Deserializes a chess board from the piece placement data of a FEN record
class BoardDeserializer
  include FenParser

  def initialize(fen)
    @fen = fen
  end

  def deserialize_board
    deserialized_piece_placement = deserialize_piece_placement
    generate_all_algebraic_coords.each_with_object({}) do |coords, hash|
      hash[coords] = deserialized_piece_placement.shift
    end
  end

  private

  def deserialize_piece_placement
    parse_piece_placement(@fen).chars.each_with_object([]) do |char, arr|
      if char_represents_white_piece?(char) || char_represents_black_piece?(char)
        arr << Square.new(construct_piece(char))
      elsif char_represents_contiguous_empty_squares?(char)
        char.to_i.times { arr << Square.new }
      elsif char == '/'
        next
      end
    end
  end

  def construct_piece(char)
    if char_represents_white_piece?(char)
      ChessConstants::PIECE_FEN_CLASS_MAP[:white][char].new(:white)
    elsif char_represents_black_piece?(char)
      ChessConstants::PIECE_FEN_CLASS_MAP[:black][char].new(:black)
    end
  end

  def generate_all_algebraic_coords
    ChessConstants::BOARD_RANKS.to_a.reverse.each_with_object([]) do |rank, arr|
      ChessConstants::BOARD_FILES.each { |file| arr << "#{file}#{rank}" }
    end
  end
end

# Test script

counter = 0
fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
b_d = BoardDeserializer.new(fen)
deserialized = b_d.deserialize_board
deserialized.each do |coords, square|
  print "#{coords}:"
  p square
  counter += 1
  if counter == ChessConstants::BOARD_FILES.to_a.length
    puts
    counter = 0
  end
end
