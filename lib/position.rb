# frozen_string_literal: true

require_relative 'fen_deserialization'

# A chess position
class Position
  extend FenDeserialization

  def initialize(instantiated_squares_and_pieces)
    @instantiated_squares_and_pieces = instantiated_squares_and_pieces
  end

  # untested
  def access_square(algebraic_id)
    @instantiated_squares_and_pieces[algebraic_id]
  end

  class << self
    def from_fen(fen)
      new(fen_to_instantiated_algebraic(fen))
    end
  end
end
