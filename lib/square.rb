# frozen_string_literal: true

# A square on a chessboard
class Square
  attr_reader :piece

  def initialize(piece = nil)
    @piece = piece
  end

  def update_piece(new_piece)
    @piece = new_piece
  end

  def remove_piece
    @piece = nil
  end
end
