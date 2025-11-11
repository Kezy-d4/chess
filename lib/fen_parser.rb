# frozen_string_literal: true

require_relative 'pieces'
require_relative 'square'
require_relative 'constants'

# Parses a FEN record
class FenParser
  FEN_PIECE_MAP = {
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

  private

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
    FenParser::FEN_PIECE_MAP[:white].key?(char)
  end

  def black_char?(char)
    FenParser::FEN_PIECE_MAP[:black].key?(char)
  end

  def contiguous_empty_char?(char)
    char.to_i.positive?
  end

  def split_ranks
    parse_data_fields[:piece_placement].split('/')
  end

  def access_rank(num)
    split_ranks.reverse[num - 1]
  end

  def number_of_ranks
    split_ranks.length
  end
end
