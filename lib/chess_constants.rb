# frozen_string_literal: true

require_relative 'pieces'

# A namespace to store chess constants for use throughout the codebase
module ChessConstants
  BOARD_RANKS = (1..8)
  BOARD_FILES = ('a'..'h')
  DEFAULT_FEN = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'

  AMOUNT_OF_BOARD_RANKS = 8
  AMOUNT_OF_BOARD_FILES = 8

  PIECE_UNICODE_MAP = {
    white: {
      king: "\u{2654}",
      queen: "\u{2655}",
      rook: "\u{2656}",
      bishop: "\u{2657}",
      knight: "\u{2658}",
      pawn: "\u{2659}"
    },
    black: {
      king: "\u{265A}",
      queen: "\u{265B}",
      rook: "\u{265C}",
      bishop: "\u{265D}",
      knight: "\u{265E}",
      pawn: "\u{265F}"
    }
  }.freeze

  PIECE_FEN_CLASS_MAP = {
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
end
