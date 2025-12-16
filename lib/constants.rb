# frozen_string_literal: true

# A namespace to store constants for use throughout the codebase
module Constants
  DEFAULT_FEN = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
  BOARD_FILE_MARKERS = ('a'..'h').to_a
  BOARD_RANK_MARKERS = (1..8).to_a.reverse
end
