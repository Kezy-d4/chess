# frozen_string_literal: true

module Chess
  # A chess board
  class Board
    extend Pieces
    extend FENCharAnalysis

    # @param squares [Hash{Integer => Hash{Symbol => Square}}]
    def initialize(squares)
      @squares = squares
    end

    class << self
      # @param fen_parser [FenParser]
      def from_fen_parser(fen_parser)
        squares = fen_parser.parse_piece_placement.each_value do |rank_hash|
          rank_hash.each do |algebraic_coords_sym, char|
            square = construct_square(algebraic_coords_sym, char)
            rank_hash[algebraic_coords_sym] = square
          end
        end
        new(squares)
      end

      private

      def construct_square(algebraic_coords_sym, char)
        algebraic_coords = AlgebraicCoords.from_s(algebraic_coords_sym.to_s)
        if char == '-'
          Square.new(algebraic_coords, char)
        elsif fen_char_represents_piece?(char)
          piece = construct_piece_from_fen_char(char)
          Square.new(algebraic_coords, piece)
        end
      end
    end

    def to_partial_fen
      arr = []
      @squares.each_key do |rank_int|
        arr << format_square_occupant_chars_by_rank(rank_int).join
      end
      arr.join('/')
    end

    def access_square(algebraic_coords_str)
      rank_int = algebraic_coords_str[1].to_i
      @squares[rank_int][algebraic_coords_str.to_sym]
    end

    def collect_white_occupied_squares
      collect_occupied_squares(:white?)
    end

    def collect_black_occupied_squares
      collect_occupied_squares(:black?)
    end

    def to_s
      arr = []
      @squares.each do |rank_int, rank_hash|
        arr << "\nRank #{rank_int}:\n"
        rank_hash.each_value do |square|
          arr << "#{square}\n"
        end
      end
      arr.join
    end

    private

    def collect_squares_by_rank(rank_int)
      @squares[rank_int].values
    end

    def collect_square_occupant_chars_by_rank(rank_int)
      collect_squares_by_rank(rank_int).map do |square|
        if square.occupied?
          self.class.convert_piece_to_fen_char(square.occupant)
        elsif square.unoccupied?
          square.occupant
        end
      end
    end

    # rubocop:disable Metrics/MethodLength
    def format_square_occupant_chars_by_rank(rank_int)
      contiguous_empty_counter = 0
      arr = []
      collect_square_occupant_chars_by_rank(rank_int).each do |char|
        if self.class.fen_char_represents_piece?(char)
          arr << contiguous_empty_counter if contiguous_empty_counter.positive?
          arr << char
          contiguous_empty_counter = 0
        elsif char == '-'
          contiguous_empty_counter += 1
        end
      end
      arr << contiguous_empty_counter if contiguous_empty_counter.positive?
      arr
    end
    # rubocop:enable all

    def collect_occupied_squares(color)
      arr = []
      @squares.each_key { |rank_int| arr << collect_squares_by_rank(rank_int) }
      arr.flatten.select { |square| square.occupied? && square.occupant.public_send(color) }
    end
  end
end
