# frozen_string_literal: true

require_relative 'chess_constants'

# Parses a chess fen record
class FenParser
  def initialize(fen)
    @fen = fen
  end

  def data_fields
    @fen.split
  end

  def piece_placement_data
    data_fields.first
  end
end
