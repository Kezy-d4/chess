# frozen_string_literal: true

# Methods to isolate and identify the six component fields of a FEN record
module FenSeparation
  # Each field of a FEN record is already naturally separated by a whitespace,
  # so the split method is very appropriate here.
  def piece_placement_data(fen_str)
    fields = fen_str.split
    fields[0]
  end

  def active_color_data(fen_str)
    fields = fen_str.split
    fields[1]
  end

  def castling_rights_data(fen_str)
    fields = fen_str.split
    fields[2]
  end

  def en_passant_target_square_data(fen_str)
    fields = fen_str.split
    fields[3]
  end

  def half_move_clock_data(fen_str)
    fields = fen_str.split
    fields[4]
  end

  def full_move_number_data(fen_str)
    fields = fen_str.split
    fields[5]
  end
end
