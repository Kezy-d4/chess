# frozen_string_literal: true

# A namespace to store constants for use throughout the codebase
module Constants
  DEFAULT_FEN = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
  BOARD_FILES = ('a'..'h')
  BOARD_RANKS = (1..8)
  BOARD_FILES_LENGTH = BOARD_FILES.to_a.length
  BOARD_RANKS_LENGTH = BOARD_RANKS.size
end
