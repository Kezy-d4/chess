# frozen_string_literal: true

require_relative 'constants'

# Parent to each of the pieces in chess
class Piece
  def initialize(color)
    @color = color
  end

  def to_s
    rgb_val = Constants::PIECE_COLOR_RGB_MAP[@color]
    "\e[38;2;#{rgb_val}m#{@icon}\e[0m"
  end
end
