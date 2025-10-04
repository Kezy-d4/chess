# frozen_string_literal: true

require_relative 'fen_parsing'
require_relative 'square'
require_relative 'pieces'
require_relative 'constants'

# Mixin to deserialize a FEN record representing a chess position
module FenDeserialization
  include FenParsing

  def fen_to_instantiated_algebraic(fen)
    hash = algebraic_hash
    instantiated_squares_and_pieces = instantiate_fen(fen)
    hash.each_key do |algebraic_id|
      hash[algebraic_id] = instantiated_squares_and_pieces.shift
    end
    hash
  end

  def instantiate_fen(fen) # rubocop:disable Metrics/MethodLength
    piece_placement_data_of_squares(fen).each_with_object([]) do |char, arr|
      if char_represents_white_piece?(char)
        arr << instantiate_square_occupied_by_white_piece(char)
      elsif char_represents_black_piece?(char)
        arr << instantiate_square_occupied_by_black_piece(char)
      elsif char_represents_contiguous_empty_squares?(char)
        char.to_i.times { arr << instantiate_empty_square }
      elsif char == '/'
        next
      end
    end
  end

  def algebraic_hash
    Constants::BOARD_RANKS.to_a.reverse.each_with_object({}) do |rank, hash|
      Constants::BOARD_FILES.each { |file| hash[:"#{file}#{rank}"] = nil }
    end
  end

  def instantiate_square_occupied_by_white_piece(char)
    piece = Constants::PIECE_FEN_CLASS_MAP[:white][char].new(:white)
    Square.new(piece)
  end

  def instantiate_square_occupied_by_black_piece(char)
    piece = Constants::PIECE_FEN_CLASS_MAP[:black][char].new(:black)
    Square.new(piece)
  end

  def instantiate_empty_square
    Square.new
  end

  private :instantiate_fen, :algebraic_hash, :instantiate_square_occupied_by_white_piece,
          :instantiate_square_occupied_by_black_piece, :instantiate_empty_square
end
