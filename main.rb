# frozen_string_literal: true

require_relative 'lib/chess'

# Main menu and player naming
Chess::CLI.main_menu_prompt_loop
player_white_name = Chess::CLI.player_name_prompt_loop(:white)
player_black_name = Chess::CLI.player_name_prompt_loop(:black)
Chess::CLI.welcome_players(player_white_name, player_black_name)

# Setting up state
fen = Chess::ChessConstants::FEN_DEFAULT
f_p = Chess::FENParser.new(fen)
board = Chess::Board.from_fen_parser(f_p)
aux_pos_data = Chess::AuxPosData.from_fen_parser(f_p)
player_white = Chess::Player.new(player_white_name, :white)
player_black = Chess::Player.new(player_black_name, :black)
metadata = Chess::Position.new_default_metadata
position = Chess::Position.new(board, aux_pos_data, player_white, player_black, metadata)
display = Chess::Display.new(board)
cli = Chess::CLI.new(position, display)

# Playing the game
cli.play
