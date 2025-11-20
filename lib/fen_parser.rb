# frozen_string_literal: true

require_relative 'square'
require_relative 'pieces'
require_relative 'constants'

# Parses a chess FEN record
class FenParser
  CHAR_PIECE_MAP = {
    white: {
      'K' => King,
      'Q' => Queen,
      'R' => Rook,
      'B' => Bishop,
      'N' => Knight,
      'P' => Pawn
    },
    black: {
      'k' => King,
      'q' => Queen,
      'r' => Rook,
      'b' => Bishop,
      'n' => Knight,
      'p' => Pawn
    }
  }.freeze

  def initialize(fen)
    @fen = fen
  end

  def parse_data_fields
    split_data = @fen.split
    { piece_placement: split_data[0],
      active_color: split_data[1],
      castling_availability: split_data[2],
      en_passant_target: split_data[3],
      half_move_clock: split_data[4],
      full_move_number: split_data[5] }
  end

  def parse_piece_placement
    current_rank = number_of_ranks
    hash = {}
    while current_rank.positive?
      hash[current_rank] = parse_rank(current_rank)
      current_rank -= 1
    end
    hash
  end

  def construct_squares
    current_rank = number_of_ranks
    hash = {}
    while current_rank.positive?
      hash[current_rank] = construct_rank(current_rank, parse_rank(current_rank))
      current_rank -= 1
    end
    hash
  end

  private

  def construct_rank(rank_num, rank_data)
    rank_data.map.with_index do |char, idx|
      file_coord = ('a'..'z').to_a[idx]
      algebraic_coords = "#{file_coord}#{rank_num}"
      if char == '-'
        Square.new(algebraic_coords)
      elsif white_char?(char) || black_char?(char)
        piece = construct_piece(char, algebraic_coords)
        Square.new(algebraic_coords, piece)
      end
    end
  end

  def construct_piece(char, algebraic_coords)
    if white_char?(char)
      FenParser::CHAR_PIECE_MAP[:white][char].new(algebraic_coords, :white, 0)
    elsif black_char?(char)
      FenParser::CHAR_PIECE_MAP[:black][char].new(algebraic_coords, :black, 0)
    end
  end

  def parse_rank(num)
    access_rank(num).chars.each_with_object([]) do |char, arr|
      if contiguous_empty_char?(char)
        char.to_i.times { arr << '-' }
      elsif white_char?(char) || black_char?(char)
        arr << char
      end
    end
  end

  def white_char?(char)
    FenParser::CHAR_PIECE_MAP[:white].key?(char)
  end

  def black_char?(char)
    FenParser::CHAR_PIECE_MAP[:black].key?(char)
  end

  def contiguous_empty_char?(char)
    char.to_i.positive?
  end

  def split_ranks
    parse_data_fields[:piece_placement].split('/')
  end

  def access_rank(num)
    idx = num - 1
    split_ranks.reverse[idx]
  end

  def number_of_ranks
    split_ranks.length
  end
end
