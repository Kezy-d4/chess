# frozen_string_literal: true

require_relative 'square'
require_relative 'pieces'
require_relative 'chess_constants'

# A mixin to parse a FEN record
module FenParser
  PIECE_FEN_CLASS_MAP = {
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

  def construct_piece(char)
    if char_represents_white_piece?(char)
      FenParser::PIECE_FEN_CLASS_MAP[:white][char].new(:white)
    elsif char_represents_black_piece?(char)
      FenParser::PIECE_FEN_CLASS_MAP[:black][char].new(:black)
    end
  end

  def construct_squares(fen)
    parse_piece_placement(fen).chars.each_with_object([]) do |char, arr|
      if char_represents_white_piece?(char) || char_represents_black_piece?(char)
        arr << Square.new(construct_piece(char))
      elsif char_represents_contiguous_empty_squares?(char)
        char.to_i.times { arr << Square.new }
      elsif char == '/'
        next
      end
    end
  end

  def parse_fen_record(fen)
    { piece_placement_data: parse_piece_placement(fen),
      active_color_data: parse_active_color(fen),
      castling_availability_data: parse_castling_availability(fen),
      en_passant_target_square_data: parse_en_passant_target_square(fen),
      half_move_clock_data: parse_half_move_clock(fen),
      full_move_number_data: parse_full_move_number(fen) }
  end

  def parse_data_fields(fen)
    fen.split
  end

  def parse_piece_placement(fen)
    parse_data_fields(fen)[0]
  end

  def parse_active_color(fen)
    parse_data_fields(fen)[1]
  end

  def parse_castling_availability(fen)
    parse_data_fields(fen)[2]
  end

  def parse_en_passant_target_square(fen)
    parse_data_fields(fen)[3]
  end

  def parse_half_move_clock(fen)
    parse_data_fields(fen)[4]
  end

  def parse_full_move_number(fen)
    parse_data_fields(fen)[5]
  end

  def char_represents_white_piece?(char)
    ChessConstants::PIECE_FEN_MAP[:white].value?(char)
  end

  def char_represents_black_piece?(char)
    ChessConstants::PIECE_FEN_MAP[:black].value?(char)
  end

  def char_represents_contiguous_empty_squares?(char)
    char.to_i.between?(1, ChessConstants::AMOUNT_OF_BOARD_FILES)
  end
end
