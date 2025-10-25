# frozen_string_literal: true

require_relative '../piece'
require_relative '../chess_constants'

# A rook chess piece
class Rook < Piece
  def initialize(color)
    super
    @icon = ChessConstants::PIECE_UNICODE_MAP[:rook]
  end

  def generate_adjacent_coords(algebraic_coords)
    {
      northern: generate_stepwise_northern_adjacent_coords(algebraic_coords),
      eastern: generate_stepwise_eastern_adjacent_coords(algebraic_coords),
      southern: generate_stepwise_southern_adjacent_coords(algebraic_coords),
      western: generate_stepwise_western_adjacent_coords(algebraic_coords)
    }.delete_if { |_direction, adjacent_coords| adjacent_coords.empty? }
  end
end
