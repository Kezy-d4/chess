# frozen_string_literal: true

module Chess
  # A chess board
  class Board
    extend Pieces
    extend FENCharAnalysis

    # @param squares [Hash{AlgebraicCoords => Square}]
    def initialize(squares)
      @squares = squares
    end

    class << self
      # @param fen_parser [FENParser]
      def from_fen_parser(fen_parser)
        squares = {}
        fen_parser.parse_piece_placement.each do |algebraic_coords_sym, char|
          algebraic_coords = AlgebraicCoords.from_s(algebraic_coords_sym.to_s)
          squares[algebraic_coords] = construct_square(char)
        end
        new(squares)
      end

      private

      def construct_square(char)
        if fen_char_represents_piece?(char)
          piece = construct_piece_from_fen_char(char)
          Square.new(piece)
        elsif char == '-'
          Square.new(char)
        end
      end
    end

    def to_partial_fen
      arr = []
      organize_into_ranks.each_value do |rank_arr|
        arr << rank_arr_to_partial_fen(rank_arr).join
      end
      arr.join('/')
    end

    def access_assoc_at(algebraic_coords_str)
      @squares.assoc(AlgebraicCoords.from_s(algebraic_coords_str))
    end

    def access_square_at(algebraic_coords_str)
      access_assoc_at(algebraic_coords_str)[1]
    end

    def access_coord_at(algebraic_coords_str)
      access_assoc_at(algebraic_coords_str)[0]
    end

    def update_at(algebraic_coords_str, piece)
      @squares[AlgebraicCoords.from_s(algebraic_coords_str)].update_occupant(piece)
    end

    def empty_at(algebraic_coords_str)
      @squares[AlgebraicCoords.from_s(algebraic_coords_str)].remove_occupant
    end

    def select_white_occupied
      select_occupied.select { |_algebraic_coords, square| square.occupant.white? }
    end

    def select_black_occupied
      select_occupied.select { |_algebraic_coords, square| square.occupant.black? }
    end

    def to_s
      arr = []
      no_of_ranks = ChessConstants::BOARD_RANK_MARKERS.length
      square_counter = 1
      @squares.each do |algebraic_coords, square|
        arr << "#{algebraic_coords}:\n"
        arr << "#{square}\n"
        arr << "\n" if square_counter.multiple_of?(no_of_ranks)
        square_counter += 1
      end
      arr.join
    end

    private

    def organize_into_ranks
      vals = @squares.values
      ChessConstants::BOARD_RANK_MARKERS.each_with_object({}) do |rank_int, hash|
        rank = vals.slice!(0, ChessConstants::BOARD_FILE_MARKERS.length)
        hash[rank_int] = rank
      end
    end

    def rank_arr_to_partial_fen(rank_arr) # rubocop:disable Metrics/MethodLength
      contiguous_empty_counter = 0
      fen_arr = rank_arr.each_with_object([]) do |square, fen_arr|
        if square.occupied?
          fen_arr << contiguous_empty_counter if contiguous_empty_counter.positive?
          fen_arr << self.class.convert_piece_to_fen_char(square.occupant)
          contiguous_empty_counter = 0
        elsif square.unoccupied?
          contiguous_empty_counter += 1
        end
      end
      fen_arr << contiguous_empty_counter if contiguous_empty_counter.positive?
      fen_arr
    end

    def select_occupied
      @squares.select do |_algebraic_coords, square|
        square.occupied?
      end
    end
  end
end
