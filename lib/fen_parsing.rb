# frozen_string_literal: true

require_relative 'constants'

# Mixin to parse a FEN record representing a chess position
module FenParsing
  def data_fields(fen)
    fen.split
  end

  def piece_placement_data(fen)
    data_fields(fen)[0]
  end

  def active_color_data(fen)
    data_fields(fen)[1]
  end

  def castling_rights_data(fen)
    data_fields(fen)[2]
  end

  def en_passant_target_square_data(fen)
    data_fields(fen)[3]
  end

  def half_move_clock_data(fen)
    data_fields(fen)[4]
  end

  def full_move_number_data(fen)
    data_fields(fen)[5]
  end

  def piece_placement_data_of_ranks(fen)
    piece_placement_data(fen).split('/')
  end

  def piece_placement_data_by_rank(fen, rank)
    piece_placement_data_of_ranks(fen).reverse[rank - 1]
  end

  def fifty_move_rule_satisfied?(fen)
    half_move_clock_data(fen).to_i >= 100
  end

  def seventy_five_move_rule_satisfied?(fen)
    half_move_clock_data(fen).to_i >= 150
  end

  def en_passant_target_square_available?(fen)
    en_passant_target_square_data(fen) != '-'
  end

  def white_kingside_castle_available?(fen)
    castling_rights_data(fen).include?(Constants::WHITE_PIECE_FEN_MAP[:king])
  end

  def white_queenside_castle_available?(fen)
    castling_rights_data(fen).include?(Constants::WHITE_PIECE_FEN_MAP[:queen])
  end

  def black_kingside_castle_available?(fen)
    castling_rights_data(fen).include?(Constants::BLACK_PIECE_FEN_MAP[:king])
  end

  def black_queenside_castle_available?(fen)
    castling_rights_data(fen).include?(Constants::BLACK_PIECE_FEN_MAP[:queen])
  end

  def white_has_the_move?(fen)
    active_color_data(fen) == 'w'
  end

  def black_has_the_move?(fen)
    active_color_data(fen) == 'b'
  end
end
