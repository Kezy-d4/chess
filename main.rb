# frozen_string_literal: true

require_relative 'lib/board'
require_relative 'lib/fen_parser'
require_relative 'lib/position'
require_relative 'lib/position_data'

default_fen_without_pawns = 'rnbqkbnr/pp6/8/8/8/8/pppppppp/RNBQKBNR w KQkq - 0 1'
f_p = FenParser.new(default_fen_without_pawns)
board = Board.from_piece_placement(f_p.parse_piece_placement)
position_data = PositionData.from_fen(default_fen_without_pawns)
position = Position.new(board, position_data)
source_square = board.access_square('b7')
destination_square = board.access_square('b5')
position.move_piece(source_square, destination_square)
pp position
