# frozen_string_literal: true

require_relative 'fen_separation'
require_relative 'constants'

# Module to generate the state of a chess position from a FEN record
module FenToPosition
  class << self
    def fen_to_position(fen_str)
      position = []
      current_rank = Constants::NUMBER_OF_RANKS
      until current_rank < 1
        position << fen_to_position_by_rank(fen_str, current_rank)
        current_rank -= 1
      end
      position
    end

    private

    def fen_to_position_by_rank(fen_str, rank_num)
      rank_position = []
      rank_fen = FenSeparation.piece_placement_data_by_rank(fen_str, rank_num)
      rank_fen.chars.each do |char|
        if char_represents_a_piece?(char)
          rank_position << char
        elsif char_represents_contiguous_empty_squares?(char)
          char.to_i.times { rank_position << nil }
        end
      end
      rank_position
    end

    def char_represents_a_piece?(char)
      char.match?(/^[A-Z]+$/i)
    end

    def char_represents_contiguous_empty_squares?(char)
      char.to_i.positive?
    end
  end
end
