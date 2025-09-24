# frozen_string_literal: true

require_relative 'fen_separation'
require_relative 'constants'

# Module to generate the state of a board position from a FEN record
module PositionGeneration
  include FenSeparation

  def position_from_fen(fen_str)
    position = []
    current_rank_num = Constants::NUMBER_OF_RANKS
    until current_rank_num < 1
      position << position_from_fen_by_rank(fen_str, current_rank_num)
      current_rank_num -= 1
    end
    position
  end

  def position_from_fen_by_rank(fen_str, rank_num)
    rank_position = []
    rank_fen = piece_placement_data_by_rank(fen_str, rank_num)
    rank_fen.chars.each do |char|
      if char.match?(/^[A-Za-z]+$/)
        rank_position << char
      else
        char.to_i.times { rank_position << nil }
      end
    end
    rank_position
  end
end
