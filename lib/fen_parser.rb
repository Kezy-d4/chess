# frozen_string_literal: true

require_relative 'constants'

# Parses a chess FEN record
class FenParser
  # @param fen [String] the valid fen record
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
    rank_arr.each_with_index do |char, idx|
      algebraic_file = Constants::BOARD_FILE_MARKERS[idx]
      algebraic_rank = rank_int
      algebraic_coords = :"#{algebraic_file}#{algebraic_rank}"
      hash[algebraic_coords] = char
    end
    hash
  end

  def parse_rank(rank_str)
    rank_str.chars.each_with_object([]) do |char, arr|
      if char_represents_piece?(char)
        arr << char
      elsif char_represents_contiguous_empty_squares?(char)
        char.to_i.times { arr << '-' }
      end
    end
  end

  def split_ranks
    parse_data_fields[:piece_placement].split('/')
  end

  def determine_number_of_ranks
    split_ranks.length
  end

  def char_represents_piece?(char)
    char.match?(/^[a-zA-Z]$/)
  end

  def char_represents_contiguous_empty_squares?(char)
    char.to_i.positive?
  end
end
