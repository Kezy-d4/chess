# frozen_string_literal: true

module Chess
  # A chess board
  class Board
    extend Pieces
    extend FENCharAnalysis

    # @param squares [Hash{Integer => Hash{AlgebraicCoords => Square}}]
    def initialize(squares)
      @squares = squares
    end

    class << self
      # @param fen_parser [FENParser]
      def from_fen_parser(fen_parser)
        parsed = fen_parser.parse_piece_placement
        squares = parsed.transform_values do |rank_hash|
          rank_hash.each_with_object({}) do |pair, hash|
            algebraic_coords_sym = pair[0]
            char = pair[1]
            algebraic_coords = AlgebraicCoords.from_s(algebraic_coords_sym.to_s)
            hash[algebraic_coords] = construct_square(char)
          end
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
      partial_fen = @squares.each_key.with_object([]) do |rank_int, arr|
        arr << format_rank_chars(rank_int)
      end
      partial_fen.join('/')
    end

    def access_association(algebraic_coords_str)
      rank_int = algebraic_coords_str[1].to_i
      algebraic_coords = AlgebraicCoords.from_s(algebraic_coords_str)
      @squares[rank_int].assoc(algebraic_coords)
    end

    def collect_white_occupied_associations
      collect_occupied_associations(:white?)
    end

    def collect_black_occupied_associations
      collect_occupied_associations(:black?)
    end

    def update_association(algebraic_coords_str, piece)
      square = access_association(algebraic_coords_str)[1]
      square.update_occupant(piece)
    end

    def reset_association(algebraic_coords_str)
      square = access_association(algebraic_coords_str)[1]
      square.remove_occupant
    end

    def to_s
      arr = []
      @squares.each do |rank_int, rank_hash|
        arr << "\nRank #{rank_int}:\n"
        rank_hash.each do |algebraic_coords, square|
          arr << "#{algebraic_coords}:\n#{square}\n"
        end
      end
      arr.join
    end

    private

    def collect_associations
      @squares.each_value.with_object([]) do |rank_hash, arr|
        rank_hash.each_key do |algebraic_coords|
          arr << rank_hash.assoc(algebraic_coords)
        end
      end
    end

    def collect_occupied_associations(color_predicate)
      collect_associations.select do |association|
        square = association[1]
        square.occupied? && square.occupant.public_send(color_predicate)
      end
    end

    def format_rank_chars(rank_int) # rubocop:disable Metrics/MethodLength
      contiguous_empty_counter = 0
      rank_chars = @squares[rank_int].values.each_with_object([]) do |square, arr|
        if square.occupied?
          arr << contiguous_empty_counter if contiguous_empty_counter.positive?
          arr << self.class.convert_piece_to_fen_char(square.occupant)
          contiguous_empty_counter = 0
        elsif square.unoccupied?
          contiguous_empty_counter += 1
        end
      end
      rank_chars << contiguous_empty_counter if contiguous_empty_counter.positive?
      rank_chars.join
    end
  end
end
