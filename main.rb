# frozen_string_literal: true

require_relative 'lib/chess'

fen_parser = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
position = Chess::Position.from_fen_parser(fen_parser, 'w', 'b')
display = Chess::Display.new
game = Chess::Game.new(position, display)
game.play
