# frozen_string_literal: true

require_relative 'constants'

# A chess position
class Position
  # @param board [Board] the board
  # @param position_data [PositionData] the position data
  def initialize(board, position_data)
    @board = board
    @position_data = position_data
  end

  def select_board_square(square)
    @board.select_square(square)
  end

  def move_piece(source_square, destination_square)
    @board.update_most_recent_source_square(source_square)
    @board.update_most_recent_destination_square(destination_square)
    piece = source_square.occupant
    source_square.remove_occupant
    destination_square.update_occupant(piece)
    piece.update_algebraic_coords(destination_square.algebraic_coords)
    piece.increment_total_moves
  end

  def generate_non_pawn_controlled_adjacencies(square)
    complete_adjacencies = square.occupant.generate_adjacent_coords
    controlled_adjacencies = complete_adjacencies.transform_values do |coords|
      coords.take_while { |coords| @board.access_square(coords).unoccupied? }
    end
    controlled_adjacencies.delete_if { |_direction, coords| coords.empty? }
  end

  def generate_non_pawn_attacked_adjacencies(square)
    complete_adjacencies = square.occupant.generate_adjacent_coords
    attacked_adjacencies = complete_adjacencies.transform_values do |coords|
      updated = coords.find do |coords|
        @board.access_square(coords).occupied? &&
          @board.access_square(coords).occupant.color != square.occupant.color
      end
      [updated]
    end
    attacked_adjacencies.delete_if { |_direction, coords| coords.compact.empty? }
  end

  def generate_pawn_controlled_adjacencies(square)
    complete_adjacencies = square.occupant.generate_adjacent_capture_coords
    controlled_adjacencies = complete_adjacencies.transform_values do |coords|
      coords.take_while { |coords| @board.access_square(coords).unoccupied? }
    end
    controlled_adjacencies.delete_if { |_direction, coords| coords.empty? }
  end
end
