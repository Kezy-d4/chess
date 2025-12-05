# frozen_string_literal: true

require_relative 'constants'

# Parses a chess FEN record
class FenParser
  # @param fen [String] the fen record
  def initialize(fen)
    @fen = fen
  end

  def parse_piece_placement
    hash = {}
    current_rank_num = determine_number_of_ranks
    until current_rank_num.zero?
      current_rank = access_rank(current_rank_num)
      hash[current_rank_num] = parse_and_label_rank(current_rank, current_rank_num)
      current_rank_num -= 1
    end
    hash
  end

  def separate_data_fields
    split_data = @fen.split
    { piece_placement: split_data[0],
      active_color: split_data[1],
      castling_availability: split_data[2],
      en_passant_target: split_data[3],
      half_move_clock: split_data[4],
      full_move_number: split_data[5] }
  end

  private

  def parse_and_label_rank(rank, rank_num)
    hash = {}
    parse_rank(rank).each_with_index do |char, idx|
      algebraic_file = Constants::BOARD_FILES[idx]
      algebraic_rank = rank_num
      algebraic_coords = :"#{algebraic_file}#{algebraic_rank}"
      hash[algebraic_coords] = char
    end
    hash
  end

  def parse_rank(rank)
    arr = []
    rank.chars.each do |char|
      if char_represents_piece?(char)
        arr << char
      elsif char_represents_contiguous_empty_squares?(char)
        char.to_i.times { arr << '-' }
      end
    end
    arr
  end

  def separate_ranks
    separate_data_fields[:piece_placement].split('/')
  end

  def determine_number_of_ranks
    separate_ranks.length
  end

  def access_rank(rank_num)
    separate_ranks.reverse[rank_num - 1]
  end

  def char_represents_piece?(char)
    char.match?(/^[a-zA-Z]$/)
  end

  def char_represents_contiguous_empty_squares?(char)
    char.to_i.positive?
  end
end
