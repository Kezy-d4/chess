# frozen_string_literal: true

module Chess
  # A mixin to construct chess pieces from their corresponding FEN character and
  # convert existing pieces into said character
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

    def construct_piece_from_char(char)
      if char_represents_white_piece?(char)
        FEN_CHAR_PIECE_MAP[:white][char].new(:white)
      elsif char_represents_black_piece?(char)
        FEN_CHAR_PIECE_MAP[:black][char].new(:black)
      end
    end

    def convert_piece_to_char(piece)
      if piece.white?
        PIECE_FEN_CHAR_MAP[:white][piece.class]
      elsif piece.black?
        PIECE_FEN_CHAR_MAP[:black][piece.class]
      end
    end
  end
end
