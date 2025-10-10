# frozen_string_literal: true

require_relative 'fen_deserialization'
require_relative 'position_serializer'
require_relative 'square'
require_relative 'pieces'
require_relative 'constants'

# The square and piece placement of a chess position
class Position
  extend FenDeserialization

  attr_reader :state

  def initialize(state)
    @state = state
  end

  class << self
    def from_fen(fen)
      new(fen_to_instantiated_algebraic(fen))
    end

    def rank_keys(rank)
      unless rank.is_a?(Integer) && rank.between?(Constants::BOARD_RANKS.min, Constants::BOARD_RANKS.max)
        raise ArgumentError, 'Expected an Integer between one and eight'
      end

      Constants::BOARD_FILES.each_with_object([]) do |file, arr|
        arr << :"#{file}#{rank}"
      end
    end
  end

  def to_piece_placement_fen
    PositionSerializer.new(self).serialize_position
  end
end
