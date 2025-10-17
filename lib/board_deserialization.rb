# frozen_string_literal: true

require_relative 'fen_parsing'
require_relative 'pieces'
require_relative 'square'
require_relative 'chess_constants'

# A mixin to deserialize a chess board from a fen record
module BoardDeserialization
  include FenParsing

  # Untested

  def deserialize_board(fen)
    instantiated_data = deserialize_piece_placement_data(fen)
    hash = algebraic_hash
    hash.each_key do |coords|
      hash[coords] = instantiated_data.shift
    end
    hash
  end

  private

  def deserialize_piece_placement_data(fen)
    piece_placement_data(fen).chars.each_with_object([]) do |char, arr|
      if char_represents_white_piece?(char) || char_represents_black_piece?(char)
        arr << Square.new(instantiate_piece(char))
      elsif char_represents_contiguous_empty_squares?(char)
        char.to_i.times { arr << Square.new }
      elsif char == '/'
        next
      end
    end
  end

  def instantiate_piece(char)
    if char_represents_white_piece?(char)
      ChessConstants::PIECE_FEN_CLASS_MAP[:white][char].new(:white)
    elsif char_represents_black_piece?(char)
      ChessConstants::PIECE_FEN_CLASS_MAP[:black][char].new(:black)
    end
  end

  def algebraic_hash
    ChessConstants::BOARD_RANKS.to_a.reverse.each_with_object({}) do |rank, hash|
      ChessConstants::BOARD_FILES.each { |file| hash["#{file}#{rank}"] = nil }
    end
  end
end
