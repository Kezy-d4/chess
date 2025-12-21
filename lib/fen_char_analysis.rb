# frozen_string_literal: true

require_relative 'chess_constants'

# A mixin to analyze the characters within the piece placement data field of a
# chess FEN record
module FENCharAnalysis
  def fen_char_represents_white_piece?(fen_char)
    ChessConstants::FEN_CHARS[:white].value?(fen_char)
  end

  def fen_char_represents_black_piece?(fen_char)
    ChessConstants::FEN_CHARS[:black].value?(fen_char)
  end

  def fen_char_represents_piece?(fen_char)
    fen_char_represents_white_piece?(fen_char) ||
      fen_char_represents_black_piece?(fen_char)
  end

  def fen_char_represents_contiguous_empty_squares?(fen_char)
    fen_char.to_i.positive?
  end
end
