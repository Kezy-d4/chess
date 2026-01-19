# frozen_string_literal: true

# Top-level namespace for the project
module Chess
  require_relative 'core_ext/numeric'
  require_relative 'chess/fen_char_analysis'
  require_relative 'chess/chess_constants'
  require_relative 'chess/piece'
  require_relative 'chess/pieces/king'
  require_relative 'chess/pieces/queen'
  require_relative 'chess/pieces/rook'
  require_relative 'chess/pieces/bishop'
  require_relative 'chess/pieces/knight'
  require_relative 'chess/pieces/pawn'
  require_relative 'chess/pieces'
  require_relative 'chess/algebraic_coords'
  require_relative 'chess/player'
  require_relative 'chess/players/white_player'
  require_relative 'chess/players/black_player'
  require_relative 'chess/aux_pos_data'
  require_relative 'chess/board'
  require_relative 'chess/fen_parser'
  require_relative 'chess/square'
end
