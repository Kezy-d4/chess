# frozen_string_literal: true

module Chess
  # A superclass to each of the chess pieces
  class Piece
    attr_reader :color, :total_moves

    # @param color [Symbol]
    # @param total_moves [Integer]
    def initialize(color, total_moves = 0)
      @color = color
      @total_moves = total_moves
    end

    def white?
      @color == :white
    end

    def black?
      @color == :black
    end

    def moved?
      @total_moves.positive?
    end

    def moved_once?
      @total_moves == 1
    end

    def moved_more_than_once?
      @total_moves > 1
    end

    def unmoved?
      @total_moves.zero?
    end

    def increment_total_moves
      @total_moves += 1
    end

    def to_s
      if unmoved?
        "The #{to_class_s} is #{@color} and has not moved."
      elsif moved_once?
        "The #{to_class_s} is #{@color} and has moved #{@total_moves} time."
      elsif moved_more_than_once?
        "The #{to_class_s} is #{@color} and has moved #{@total_moves} times."
      end
    end
  end
end
