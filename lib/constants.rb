# frozen_string_literal: true

# Module to store constants for use throughout the codebase
module Constants
  NUMBER_OF_RANKS = 8
  NUMBER_OF_FILES = 8

  SQUARE_COLOR_RGB_MAP = { green: '119;162;109',
                           yellow: '200;194;100' }.freeze

  PLAYER_COLOR_RGB_MAP = { white: '255;255;255',
                           black: '0;0;0' }.freeze

  PIECE_UNICODE_ICON_MAP = { king: "\u{265A}",
                             queen: "\u{265B}",
                             rook: "\u{265C}",
                             bishop: "\u{265D}",
                             knight: "\u{265E}",
                             pawn: "\u{2659}" }.freeze
end
