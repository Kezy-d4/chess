# frozen_string_literal: true

# Module to store constants for use throughout the codebase
module Constants
  NUMBER_OF_RANKS = 8
  NUMBER_OF_FILES = 8

  SQUARE_COLOR_RGB_MAP = { green: '119;162;109',
                           yellow: '200;194;100' }.freeze

  PLAYER_COLOR_RGB_MAP = { white: '255;255;255',
                           black: '0;0;0' }.freeze

  PIECE_UNICODE_ICON_MAP = { K: "\u{265A}",
                             k: "\u{265A}",
                             Q: "\u{265B}",
                             q: "\u{265B}",
                             R: "\u{265C}",
                             r: "\u{265C}",
                             B: "\u{265D}",
                             b: "\u{265D}",
                             N: "\u{265E}",
                             n: "\u{265E}",
                             P: "\u{2659}",
                             p: "\u{2659}" }.freeze
end
