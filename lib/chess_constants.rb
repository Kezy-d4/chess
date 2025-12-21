# frozen_string_literal: true

# A namespace to store chess constants for use throughout the codebase
module ChessConstants
  DEFAULT_FEN = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
  BOARD_FILE_MARKERS = ('a'..'h').to_a
  BOARD_RANK_MARKERS = (1..8).to_a.reverse
  FEN_CHARS = {
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
end
