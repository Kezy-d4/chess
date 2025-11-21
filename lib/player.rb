# frozen_string_literal: true

require_relative 'constants'

# A chess player
class Player
  def initialize(name, color, owned_pieces)
    @name = name
    @color = color
    @owned_pieces = owned_pieces
  end

  def white?
    @color == :white
  end

  def black?
    @color == :black
  end
end
