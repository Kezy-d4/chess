# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'constants'

# An overall chess position
class Position
  def initialize(board, white_player, black_player)
    @board = board
    @white_player = white_player
    @black_player = black_player
  end
end
