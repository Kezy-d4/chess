# frozen_string_literal: true

require_relative 'fen_deserialization'
require_relative 'square'
require_relative 'pieces'

# A chess position
class Position
  extend FenDeserialization

  def initialize(instantiated_squares_and_pieces)
    @instantiated_squares_and_pieces = instantiated_squares_and_pieces
  end

  class << self
    def from_fen(fen)
      new(fen_to_instantiated_algebraic(fen))
    end

    def rank_keys(rank)
      Constants::BOARD_FILES.each_with_object([]) do |file, arr|
        arr << :"#{file}#{rank}"
      end
    end
  end

  def access_square(algebraic_id)
    @instantiated_squares_and_pieces[algebraic_id]
  end
end
