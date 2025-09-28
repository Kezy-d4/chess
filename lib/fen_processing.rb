# frozen_string_literal: true

# Mixin to process a FEN record representing a chess position
module FenProcessing
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
end
