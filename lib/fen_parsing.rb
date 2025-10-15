# frozen_string_literal: true

require_relative 'chess_constants'

# A mixin to parse a fen record
module FenParsing
  def data_fields(fen)
    fen.split
  end

  def piece_placement_data(fen)
    data_fields(fen)[0]
  end
end
