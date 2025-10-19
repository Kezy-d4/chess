# frozen_string_literal: true

require_relative 'board_deserializer'
require_relative 'chess_constants'

class Board
  def initialize(squares)
    @squares = squares
  end

  class << self
    def from_fen(fen)
      new(BoardDeserializer.new(fen).deserialize_board)
    end
  end
end
