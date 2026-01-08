# frozen_string_literal: true

module Chess
  # A square on a chess board
  class Square
    attr_reader :occupant

    # @param occupant [Piece, String]
    def initialize(occupant)
      @occupant = occupant
    end

    def occupied?
      @occupant != '-'
    end

    def unoccupied?
      @occupant == '-'
    end

    def update_occupant(new_occupant)
      @occupant = new_occupant
    end

    def remove_occupant
      occupant_to_remove = @occupant
      @occupant = '-'
      occupant_to_remove
    end

    def to_class_s
      class_string = self.class.to_s
      class_string.slice!('Chess::')
      class_string
    end

    def to_s
      if occupied?
        "The #{to_class_s} is occupied by a #{@occupant.to_class_s}.\n" \
          "\s\s#{@occupant}"
      elsif unoccupied?
        "The #{to_class_s} is unoccupied."
      end
    end
  end
end
