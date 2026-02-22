# frozen_string_literal: true

require_relative 'lib/chess'

# setup
fen = Chess::ChessConstants::FEN_DEFAULT
f_p = Chess::FENParser.new(fen)
board = Chess::Board.from_fen_parser(f_p)
aux_pos_data = Chess::AuxPosData.from_fen_parser(f_p)
player_white = Chess::Player.new('w', :white)
player_black = Chess::Player.new('b', :black)
log = Chess::Log.new({})
position = Chess::Position.new(board, aux_pos_data, player_white, player_black, log)
display = Chess::Display.new

# initial
puts "Initial:\n\n"
display.render_board(position.to_board_ranks, position.dump_log[:metadata])

# 1.
puts "1.\n\n"

position.select_source(Chess::Coord.from_s('b1'))
display.render_board(position.to_board_ranks, position.dump_log[:metadata])
puts

position.move(position.dump_log[:metadata][:current_source], Chess::Coord.from_s('c3'))
position.swap_active_player
position.deselect_source
display.render_board(position.to_board_ranks, position.dump_log[:metadata])

# 1...
puts "1...\n\n"

position.select_source(Chess::Coord.from_s('e7'))
display.render_board(position.to_board_ranks, position.dump_log[:metadata])
puts

position.move(position.dump_log[:metadata][:current_source], Chess::Coord.from_s('e5'))
position.swap_active_player
position.deselect_source
display.render_board(position.to_board_ranks, position.dump_log[:metadata])

# 2.
puts "2.\n\n"

position.select_source(Chess::Coord.from_s('d2'))
display.render_board(position.to_board_ranks, position.dump_log[:metadata])
puts

position.move(position.dump_log[:metadata][:current_source], Chess::Coord.from_s('d4'))
position.swap_active_player
position.deselect_source
display.render_board(position.to_board_ranks, position.dump_log[:metadata])

# 2...
puts "2...\n\n"

position.select_source(Chess::Coord.from_s('e5'))
display.render_board(position.to_board_ranks, position.dump_log[:metadata])
puts

position.move(position.dump_log[:metadata][:current_source], Chess::Coord.from_s('d4'))
position.swap_active_player
position.deselect_source
display.render_board(position.to_board_ranks, position.dump_log[:metadata])

# 3.
puts "3.\n\n"

position.select_source(Chess::Coord.from_s('d1'))
display.render_board(position.to_board_ranks, position.dump_log[:metadata])
puts

position.move(position.dump_log[:metadata][:current_source], Chess::Coord.from_s('d4'))
position.swap_active_player
position.deselect_source
display.render_board(position.to_board_ranks, position.dump_log[:metadata])

# 3...
puts "3...\n\n"

position.select_source(Chess::Coord.from_s('d8'))
display.render_board(position.to_board_ranks, position.dump_log[:metadata])
puts

position.move(position.dump_log[:metadata][:current_source], Chess::Coord.from_s('f6'))
position.swap_active_player
position.deselect_source
display.render_board(position.to_board_ranks, position.dump_log[:metadata])

# 4.
puts "4.\n\n"

position.select_source(Chess::Coord.from_s('g1'))
display.render_board(position.to_board_ranks, position.dump_log[:metadata])
puts

position.move(position.dump_log[:metadata][:current_source], Chess::Coord.from_s('f3'))
position.swap_active_player
position.deselect_source
display.render_board(position.to_board_ranks, position.dump_log[:metadata])

# 4...
puts "4...\n\n"

position.select_source(Chess::Coord.from_s('f6'))
display.render_board(position.to_board_ranks, position.dump_log[:metadata])
puts
