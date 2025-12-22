# frozen_string_literal: true

require_relative 'fen_char_analysis'
require_relative 'chess_constants'

# Parses a chess FEN record
class FENParser
  include FENCharAnalysis

  # @param fen [String] the valid FEN record
  def initialize(fen)
    @fen = fen
  end

  def parse_piece_placement
    current_rank_int = determine_number_of_ranks
    split_ranks.each_with_object({}) do |rank_str, hash|
      rank_arr = parse_rank(rank_str)
      hash[current_rank_int] = parse_rank_with_coords(rank_arr, current_rank_int)
      current_rank_int -= 1
    end
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

  private

  def parse_rank_with_coords(rank_arr, rank_int)
    hash = {}
    rank_arr.each_with_index do |fen_char, idx|
      algebraic_file = ChessConstants::BOARD_FILE_MARKERS[idx]
      algebraic_rank = rank_int
      algebraic_coords_sym = :"#{algebraic_file}#{algebraic_rank}"
      hash[algebraic_coords_sym] = fen_char
    end
    hash
  end

  def parse_rank(rank_str)
    rank_str.chars.each_with_object([]) do |fen_char, arr|
      if fen_char_represents_piece?(fen_char)
        arr << fen_char
      elsif fen_char_represents_contiguous_empty_squares?(fen_char)
        fen_char.to_i.times { arr << '-' }
      end
    end
  end

  def split_ranks
    parse_data_fields[:piece_placement].split('/')
  end

  def determine_number_of_ranks
    split_ranks.length
  end
end
