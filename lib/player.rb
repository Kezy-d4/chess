# frozen_string_literal: true

require_relative 'chess_constants'

# A superclass to each of the chess players
class Player
  # @param name [String]
  def initialize(name)
    @name = name
  end
end
