# frozen_string_literal: true

require_relative '../piece'
require_relative '../chess_constants'

# A king chess piece
class King < Piece
  def initialize(color)
    super
    @icon = ChessConstants::PIECE_UNICODE_MAP[:king]
  end

  def generate_adjacent_coords(algebraic_coords) # rubocop:disable Metrics/AbcSize
    {
      northern: generate_stepwise_northern_adjacent_coords(algebraic_coords).first,
      eastern: generate_stepwise_eastern_adjacent_coords(algebraic_coords).first,
      southern: generate_stepwise_southern_adjacent_coords(algebraic_coords).first,
      western: generate_stepwise_western_adjacent_coords(algebraic_coords).first,
      north_eastern: generate_stepwise_north_eastern_adjacent_coords(algebraic_coords).first,
      south_eastern: generate_stepwise_south_eastern_adjacent_coords(algebraic_coords).first,
      south_western: generate_stepwise_south_western_adjacent_coords(algebraic_coords).first,
      north_western: generate_stepwise_north_western_adjacent_coords(algebraic_coords).first
    }.delete_if { |_direction, adjacent_coords| adjacent_coords.nil? }
  end

  def moves_stepwise?
    false
  end
end
