# frozen_string_literal: true

require_relative 'constants'

# Serializes the piece placement data of a position into FEN format
class PositionSerializer
  def initialize(position)
    @position = position
    @contiguous_empty_square_counter = 0
  end

  def serialize_position
    serialized =
      Constants::BOARD_RANKS.to_a.reverse.each_with_object([]) do |rank, arr|
        reset_contiguous_empty_square_counter
        arr << serialize_rank(rank)
        arr << '/' unless rank == Constants::BOARD_RANKS.min
      end
    serialized.join
  end

  private

  def serialize_rank(rank) # rubocop:disable Metrics/MethodLength
    Position.rank_keys(rank).each_with_object([]) do |algebraic_id, arr|
      square = @position.instantiated_squares_and_pieces[algebraic_id]
      if square.empty?
        increment_contiguous_empty_square_counter
        arr << @contiguous_empty_square_counter.to_s if h_file?(algebraic_id)
      elsif square.occupied?
        arr << @contiguous_empty_square_counter if @contiguous_empty_square_counter.positive?
        arr << square.occupant_fen
        reset_contiguous_empty_square_counter
      end
    end
  end

  def h_file?(algebraic_id)
    algebraic_id.to_s[0] == Constants::BOARD_FILES.last
  end

  def increment_contiguous_empty_square_counter
    @contiguous_empty_square_counter += 1
  end

  def reset_contiguous_empty_square_counter
    @contiguous_empty_square_counter = 0
  end
end
