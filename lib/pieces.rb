# frozen_string_literal: true

require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'fen_char_analysis'
require_relative 'chess_constants'

# A mixin to construct chess pieces from their corresponding FEN character and
# convert existing pieces back into said character
module Pieces
  include FENCharAnalysis

  FEN_CHAR_PIECE_MAP = {
    white: {
      'K' => King,
      'Q' => Queen,
      'R' => Rook,
      'B' => Bishop,
      'N' => Knight,
      'P' => Pawn
    },
    black: {
      'k' => King,
      'q' => Queen,
      'r' => Rook,
      'b' => Bishop,
      'n' => Knight,
      'p' => Pawn
    }
  }.freeze

  PIECE_FEN_CHAR_MAP = {
    white: {
      King => 'K',
      Queen => 'Q',
      Rook => 'R',
      Bishop => 'B',
      Knight => 'N',
      Pawn => 'P'
    },
    black: {
      King => 'k',
      Queen => 'q',
      Rook => 'r',
      Bishop => 'b',
      Knight => 'n',
      Pawn => 'p'
    }
  }.freeze

  def construct_piece_from_fen_char(fen_char)
    if fen_char_represents_white_piece?(fen_char)
      FEN_CHAR_PIECE_MAP[:white][fen_char].new(:white)
    elsif fen_char_represents_black_piece?(fen_char)
      FEN_CHAR_PIECE_MAP[:black][fen_char].new(:black)
    end
  end

  def convert_piece_to_fen_char(piece)
    if piece.white?
      PIECE_FEN_CHAR_MAP[:white][piece.class]
    elsif piece.black?
      PIECE_FEN_CHAR_MAP[:black][piece.class]
    end
  end
end
