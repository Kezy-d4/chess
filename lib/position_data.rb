# frozen_string_literal: true

require_relative 'constants'

# The data representing a chess position excluding piece placement
class PositionData
  # @param data [Hash<Symbol, String>] the data
  def initialize(data)
    @data = data
  end

  class << self
    # @param fen [String] the fen record
    def from_fen(fen)
      split_data = fen.split
      new(
        { active_color: split_data[1],
          castling_availability: split_data[2],
          en_passant_target: split_data[3],
          half_move_clock: split_data[4],
          full_move_number: split_data[5] }
      )
    end
  end

  def white_has_the_move?
    @data[:active_color] == 'w'
  end

  def black_has_the_move?
    @data[:active_color] == 'b'
  end

  def swap_active_color
    if white_has_the_move?
      @data[:active_color] = 'b'
    elsif black_has_the_move?
      @data[:active_color] = 'w'
    end
  end

  def white_can_castle_kingside?
    @data[:castling_availability].include?('K')
  end

  def white_can_castle_queenside?
    @data[:castling_availability].include?('Q')
  end

  def black_can_castle_kingside?
    @data[:castling_availability].include?('k')
  end

  def black_can_castle_queenside?
    @data[:castling_availability].include?('q')
  end

  def remove_white_kingside_castling_availability
    @data[:castling_availability].delete!('K')
  end

  def remove_white_queenside_castling_availability
    @data[:castling_availability].delete!('Q')
  end

  def remove_black_kingside_castling_availability
    @data[:castling_availability].delete!('k')
  end

  def remove_black_queenside_castling_availability
    @data[:castling_availability].delete!('q')
  end

  def en_passant_available?
    @data[:en_passant_target] != '-'
  end

  def en_passant_unavailable?
    @data[:en_passant_target] == '-'
  end

  def update_en_passant_target(new_en_passant_target)
    @data[:en_passant_target] = new_en_passant_target
  end

  def reset_en_passant_target
    en_passant_target_to_reset = @data[:en_passant_target]
    @data[:en_passant_target] = '-'
    en_passant_target_to_reset
  end

  def access_en_passant_target
    @data[:en_passant_target]
  end

  def fifty_move_rule_satisfied?
    @data[:half_move_clock].to_i == 100
  end

  def seventy_five_move_rule_satisfied?
    @data[:half_move_clock].to_i == 150
  end

  def increment_half_move_clock
    @data[:half_move_clock] = (@data[:half_move_clock].to_i + 1).to_s
  end

  def increment_full_move_number
    @data[:full_move_number] = (@data[:full_move_number].to_i + 1).to_s
  end
end
