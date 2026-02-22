# frozen_string_literal: true

module Chess
  # A chess board
  class Board
    extend Pieces
    extend FENCharAnalysis

    using NumericExtensions

    # @param squares [Hash{Coord => Square}]
    def initialize(squares)
      @squares = squares
    end

    class << self
      # @param fen_parser [FENParser]
      def from_fen_parser(fen_parser)
        squares = {}
        fen_parser.to_piece_placement.each do |coord_s, char|
          coord = Coord.from_s(coord_s)
          squares[coord] = construct_square(char)
        end
        new(squares)
      end

      private

      def construct_square(char)
        if char_represents_piece?(char)
          piece = construct_piece_from_char(char)
          Square.new(piece)
        elsif char == '-'
          Square.new
        end
      end
    end

    def to_partial_fen
      arr = []
      to_ranks.each_value do |rank_a|
        arr << rank_a_to_partial_fen(rank_a)
      end
      arr.join('/')
    end

    def assoc_at(coord)
      @squares.assoc(coord)
    end

    def square_at(coord)
      @squares[coord]
    end

    def update_at(coord, piece)
      square_at(coord).update_occupant(piece)
    end

    def empty_at(coord)
      square_at(coord).remove_occupant
    end

    def occupied_at?(coord)
      square_at(coord).occupied?
    end

    def unoccupied_at?(coord)
      square_at(coord).unoccupied?
    end

    def to_white_occupied_associations
      to_occupied_associations.select { |_coord, square| square.occupant.white? }
    end

    def to_black_occupied_associations
      to_occupied_associations.select { |_coord, square| square.occupant.black? }
    end

    def to_ranks
      vals = @squares.values
      ChessConstants::BOARD_RANK_MARKERS.each_with_object({}) do |rank_i, hash|
        rank = vals.slice!(0, ChessConstants::BOARD_FILE_MARKERS.length)
        hash[rank_i] = rank
      end
    end

    def to_s
      arr = []
      no_of_ranks = ChessConstants::BOARD_RANK_MARKERS.length
      square_counter = 1
      @squares.each do |coord, square|
        arr << "#{coord}:\n"
        arr << "#{square}\n"
        arr << "\n" if square_counter.multiple_of?(no_of_ranks)
        square_counter += 1
      end
      arr.join
    end

    private

    def rank_a_to_partial_fen(rank_a) # rubocop:disable Metrics/MethodLength
      contiguous_empty_counter = 0
      fen_a = rank_a.each_with_object([]) do |square, fen_a|
        if square.occupied?
          fen_a << contiguous_empty_counter if contiguous_empty_counter.positive?
          fen_a << self.class.convert_piece_to_char(square.occupant)
          contiguous_empty_counter = 0
        elsif square.unoccupied?
          contiguous_empty_counter += 1
        end
      end
      fen_a << contiguous_empty_counter if contiguous_empty_counter.positive?
      fen_a.join
    end

    def to_occupied_associations
      @squares.select { |_coord, square| square.occupied? }
    end
  end
end
