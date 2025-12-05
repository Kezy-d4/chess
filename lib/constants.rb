# frozen_string_literal: true

# A namespace to store constants for use throughout the codebase
module Constants
  DEFAULT_FEN = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
  BOARD_FILES = ('a'..'h').to_a
  BOARD_RANKS = (1..8).to_a.reverse
  BOARD_FILES_LENGTH = BOARD_FILES.length
  BOARD_RANKS_LENGTH = BOARD_RANKS.length
end
