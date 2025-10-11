# frozen_string_literal: true

require_relative 'piece'
require_relative 'pieces'

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

  def empty?
    @piece.nil?
  end

  def occupied?
    @piece.is_a?(Piece)
  end
end
