# frozen_string_literal: true

require_relative 'pieces'

# Namespace to store constants for use throughout the codebase
module Constants
  NUMBER_OF_BOARD_FILES = 8
  NUMBER_OF_BOARD_RANKS = 8
  BOARD_FILES = ('a'..'h')
  BOARD_RANKS = (1..8)

  SQUARE_COLOR_RGB_MAP = {
    yellow: '200, 194, 100',
    green: '119, 162, 109'
  }.freeze

  PIECE_COLOR_RGB_MAP = {
    white: '255, 255, 255',
    black: '0, 0, 0'
  }.freeze

  WHITE_PIECE_FEN_MAP = {
    king: 'K',
    queen: 'Q',
    rook: 'R',
    bishop: 'B',
    knight: 'N',
    pawn: 'P'
  }.freeze

  BLACK_PIECE_FEN_MAP = {
    king: 'k',
    queen: 'q',
    rook: 'r',
    bishop: 'b',
    knight: 'n',
    pawn: 'p'
  }.freeze

  PIECE_UNICODE_ICON_MAP = {
    king: "\u{265A}",
    queen: "\u{265B}",
    rook: "\u{265C}",
    bishop: "\u{265D}",
    knight: "\u{265E}",
    pawn: "\u{2659}"
  }.freeze

  PIECE_FEN_CLASS_MAP = {
    white: { 'K' => King, 'Q' => Queen, 'R' => Rook, 'B' => Bishop, 'N' => Knight, 'P' => Pawn },
    black: { 'k' => King, 'q' => Queen, 'r' => Rook, 'b' => Bishop, 'n' => Knight, 'p' => Pawn }
  }.freeze

  PIECE_CLASS_FEN_MAP = {
    white: { King => 'K', Queen => 'Q', Rook => 'R', Bishop => 'B', Knight => 'N', Pawn => 'P' },
    black: { King => 'k', Queen => 'q', Rook => 'r', Bishop => 'b', Knight => 'n', Pawn => 'p' }
  }.freeze
end
