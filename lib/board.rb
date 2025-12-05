# frozen_string_literal: true

require_relative 'square'
require_relative 'pieces'
require_relative 'constants'

# A chess board
class Board
  FEN_CHAR_PIECE_MAP = {
    white: {
      'K' => King,
      'Q' => Queen,
      'R' => Rook,
      'B' => Bishop,
      'N' => Knight,
      'P' => Pawn
    },
    black: {
      'k' => King,
      'q' => Queen,
      'r' => Rook,
      'b' => Bishop,
      'n' => Knight,
      'p' => Pawn
    }
  }.freeze

  # @param squares [Hash<Integer, Hash<Symbol, Square>>] the squares
  def initialize(squares)
    @squares = squares
  end

  class << self
    # @param piece_placement [Hash<Integer, Hash<Symbol, String>>] the piece placement
    def from_piece_placement(piece_placement)
      outer_hash = {}
      piece_placement.each do |rank_num, rank|
        inner_hash = {}
        rank.each do |algebraic_coords, char|
          inner_hash[algebraic_coords] = construct_square(algebraic_coords.to_s, char)
        end
        outer_hash[rank_num] = inner_hash
      end
      new(outer_hash)
    end

    private

    def construct_square(algebraic_coords, char)
      if char_represents_piece?(char)
        piece = construct_piece(algebraic_coords, char)
        Square.new(algebraic_coords, piece)
      elsif char_void?(char)
        Square.new(algebraic_coords)
      end
    end

    def construct_piece(algebraic_coords, char)
      if char_represents_white_piece?(char)
        FEN_CHAR_PIECE_MAP[:white][char].new(algebraic_coords, :white)
      elsif char_represents_black_piece?(char)
        FEN_CHAR_PIECE_MAP[:black][char].new(algebraic_coords, :black)
      end
    end

    def char_represents_white_piece?(char)
      FEN_CHAR_PIECE_MAP[:white].include?(char)
    end

    def char_represents_black_piece?(char)
      FEN_CHAR_PIECE_MAP[:black].include?(char)
    end

    def char_represents_piece?(char)
      char_represents_white_piece?(char) || char_represents_black_piece?(char)
    end

    def char_void?(char)
      char == '-'
    end
  end

  def access_square(algebraic_coords)
    rank_num = algebraic_coords[1].to_i
    @squares[rank_num][algebraic_coords.to_sym]
  end

  def to_s
    arr = []
    @squares.each do |rank_num, rank|
      arr << "rank: #{rank_num}\n"
      rank.each do |algebraic_coords, square|
        arr << "\s\s#{algebraic_coords}: #{square}\n"
      end
    end
    arr.join
  end
end
