# frozen_string_literal: true

require_relative '../piece'
require_relative '../chess_constants'

# A pawn chess piece
class Pawn < Piece
  def initialize(color)
    super
    @icon = ChessConstants::PIECE_UNICODE_MAP[:pawn]
  end

  def generate_adjacent_coords(algebraic_coords) # rubocop:disable Metrics/MethodLength
    if white?
      {
        north_western: generate_stepwise_north_western_adjacent_coords(algebraic_coords).first,
        north_eastern: generate_stepwise_north_eastern_adjacent_coords(algebraic_coords).first
      }.delete_if { |_direction, adjacent_coords| adjacent_coords.nil? }
    elsif black?
      {
        south_western: generate_stepwise_south_western_adjacent_coords(algebraic_coords).first,
        south_eastern: generate_stepwise_south_eastern_adjacent_coords(algebraic_coords).first
      }.delete_if { |_direction, adjacent_coords| adjacent_coords.nil? }
    end
  end

  def moves_stepwise?
    false
  end
end
