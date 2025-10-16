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

  def char_represents_white_piece?(char)
    ChessConstants::PIECE_FEN_CLASS_MAP[:white].key?(char)
  end

  def char_represents_black_piece?(char)
    ChessConstants::PIECE_FEN_CLASS_MAP[:black].key?(char)
  end

  def char_represents_contiguous_empty_squares?(char)
    char.to_i.between?(1, ChessConstants::BOARD_FILES.to_a.length)
  end
end
