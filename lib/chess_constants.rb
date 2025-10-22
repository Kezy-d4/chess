# frozen_string_literal: true

# A namespace to store chess constants for use throughout the codebase
module ChessConstants
  BOARD_RANKS = (1..8)
  BOARD_FILES = ('a'..'h')
  AMOUNT_OF_BOARD_RANKS = 8
  AMOUNT_OF_BOARD_FILES = 8
  DEFAULT_FEN = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'

  COLOR_RGB_MAP = {
    white: '255, 255, 255',
    black: '0, 0, 0',
    muted_yellow: '199, 194, 99',
    muted_green: '119, 163, 109',
    intense_red: '232, 39, 32',
    muted_purple: '99, 83, 92',
    mid_purple: '128, 73, 102'
  }.freeze

  PIECE_UNICODE_MAP = {
    king: "\u{265A}",
    queen: "\u{265B}",
    rook: "\u{265C}",
    bishop: "\u{265D}",
    knight: "\u{265E}",
    pawn: "\u{2659}"
  }.freeze

  PIECE_FEN_MAP = {
    white: {
      king: 'K',
      queen: 'Q',
      rook: 'R',
      bishop: 'B',
      knight: 'N',
      pawn: 'P'
    },
    black: {
      king: 'k',
      queen: 'q',
      rook: 'r',
      bishop: 'b',
      knight: 'n',
      pawn: 'p'
    }
  }.freeze

  BOARD_FILE_NUMBER_MAP = {
    'a' => '1',
    'b' => '2',
    'c' => '3',
    'd' => '4',
    'e' => '5',
    'f' => '6',
    'g' => '7',
    'h' => '8'
  }.freeze

  NUMBER_BOARD_FILE_MAP = {
    '1' => 'a',
    '2' => 'b',
    '3' => 'c',
    '4' => 'd',
    '5' => 'e',
    '6' => 'f',
    '7' => 'g',
    '8' => 'h'
  }.freeze
end
