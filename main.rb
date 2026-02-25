# frozen_string_literal: true

require_relative 'lib/chess'

game = Chess::Game.new(Chess::Position.new_default('w', 'b'), Chess::Display.new)
game.play
