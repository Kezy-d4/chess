# frozen_string_literal: true

require_relative 'square'
require_relative 'fen_parsing'
require_relative 'pieces'
require_relative 'constants'

# Standalone module to deserialize a FEN record representing a chess position
class FenDeserialization
  extend FenParsing

  class << self
    def fen_to_position(fen)
      Constants::BOARD_RANKS.to_a.reverse.each_with_object({}) do |rank, position|
        squares = {}
        rank_data = piece_placement_data_by_rank(fen, rank)
        Constants::BOARD_FILES.each do |file|
          occupant = rank_data.first.nil? ? nil : instantiate_piece(rank_data.first)
          squares[:"#{file}#{rank}"] = Square.new(occupant)
          rank_data = rank_data[1..]
        end
        position[rank] = squares
      end
    end

    private

    def instantiate_piece(char)
      color = char_represents_white_piece?(char) ? :white : :black
      Constants::PIECE_FEN_CLASS_MAP[color][char.to_sym].new(color)
    end
  end
end

# test script
# position = FenDeserialization.fen_to_position('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
# position.each do |rank, squares|
#   puts "#{rank} "
#   squares.each do |algebraic_id, square|
#     print "#{algebraic_id}:"
#     p square
#   end
# end
