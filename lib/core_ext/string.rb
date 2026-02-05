# frozen_string_literal: true

# Extending core class String
class String
  def valid_coord?
    length == 2 &&
      Chess::ChessConstants::BOARD_FILE_MARKERS.include?(self[0]) &&
      Chess::ChessConstants::BOARD_RANK_MARKERS.include?(self[1].to_i)
  end
end
