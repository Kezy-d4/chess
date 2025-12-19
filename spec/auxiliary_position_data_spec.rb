# frozen_string_literal: true

require_relative '../lib/auxiliary_position_data'

# TODO(low priority): Refactor this spec to work identically as now but by only
# using let locally to improve readability.

describe AuxiliaryPositionData do
  let(:default_data_fields) do
    { piece_placement: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR',
      active_color: 'w',
      castling_availability: 'KQkq',
      en_passant_target: '-',
      half_move_clock: '0',
      full_move_number: '1' }
  end

  let(:endgame_data_fields) do
    { piece_placement: 'kq6/8/8/8/8/8/7P/7K',
      active_color: 'b',
      castling_availability: '-',
      en_passant_target: '-',
      half_move_clock: '0',
      full_move_number: '65' }
  end

  let(:fen_parser_default) do
    double('FenParser', parse_data_fields: default_data_fields)
  end

  let(:fen_parser_endgame) do
    double('FenParser', parse_data_fields: endgame_data_fields)
  end

  describe '::from_fen_parser' do
    context 'when passed a FenParser with the default fen record' do
      subject { described_class }

      let(:expected) do
        data_fields = default_data_fields
        data_fields.delete(:piece_placement)
        data_fields
      end

      it 'returns an AuxiliaryPositionData object with the expected state' do
        result = described_class.from_fen_parser(fen_parser_default)
        data_fields = result.instance_variable_get(:@data_fields)
        expect(data_fields).to eq(expected)
      end
    end

    context 'when passed a FenParser with an endgame fen record' do
      subject { described_class }

      let(:expected) do
        data_fields = endgame_data_fields
        data_fields.delete(:piece_placement)
        data_fields
      end

      it 'returns an AuxiliaryPositionData object with the expected state' do
        result = described_class.from_fen_parser(fen_parser_endgame)
        data_fields = result.instance_variable_get(:@data_fields)
        expect(data_fields).to eq(expected)
      end
    end
  end

  describe '#to_partial_fen' do
    context 'when testing with a default AuxiliaryPositionData' do
      subject(:auxiliary_position_data_default) do
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'returns a partial fen record based on the data' do
        result = auxiliary_position_data_default.to_partial_fen
        expect(result).to eq('w KQkq - 0 1')
      end
    end

    context 'when testing with an endgame AuxiliaryPositionData' do
      subject(:auxiliary_position_data_endgame) do
        described_class.from_fen_parser(fen_parser_endgame)
      end

      it 'returns a partial fen record based on the data' do
        result = auxiliary_position_data_endgame.to_partial_fen
        expect(result).to eq('b - - 0 65')
      end
    end
  end

  describe '#white_has_the_move?' do
    context 'when white has the move' do
      subject(:auxiliary_position_data_white_active) do
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'returns true' do
        result = auxiliary_position_data_white_active.white_has_the_move?
        expect(result).to be(true)
      end
    end

    context 'when black has the move' do
      subject(:auxiliary_position_data_black_active) do
        described_class.from_fen_parser(fen_parser_endgame)
      end

      it 'returns false' do
        result = auxiliary_position_data_black_active.white_has_the_move?
        expect(result).to be(false)
      end
    end
  end

  describe '#black_has_the_move?' do
    context 'when black has the move' do
      subject(:auxiliary_position_data_black_active) do
        described_class.from_fen_parser(fen_parser_endgame)
      end

      it 'returns true' do
        result = auxiliary_position_data_black_active.black_has_the_move?
        expect(result).to be(true)
      end
    end

    context 'when white has the move' do
      subject(:auxiliary_position_data_white_active) do
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'returns false' do
        result = auxiliary_position_data_white_active.black_has_the_move?
        expect(result).to be(false)
      end
    end
  end

  describe '#swap_active_color' do
    context 'when white is active' do
      subject(:auxiliary_position_data_white_active) do
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'swaps the active color to black' do
        auxiliary_position_data_white_active.swap_active_color
        data_fields = auxiliary_position_data_white_active.instance_variable_get(:@data_fields)
        swapped_active_color = data_fields[:active_color]
        expect(swapped_active_color).to eq('b')
      end
    end

    context 'when black is active' do
      subject(:auxiliary_position_data_black_active) do
        described_class.from_fen_parser(fen_parser_endgame)
      end

      it 'swaps the active color to white' do
        auxiliary_position_data_black_active.swap_active_color
        data_fields = auxiliary_position_data_black_active.instance_variable_get(:@data_fields)
        swapped_active_color = data_fields[:active_color]
        expect(swapped_active_color).to eq('w')
      end
    end
  end

  describe '#white_kingside_castle_available?' do
    context 'when white kingside castling is available' do
      subject(:auxiliary_position_data_white_kingside) do
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'returns true' do
        result = auxiliary_position_data_white_kingside.white_kingside_castle_available?
        expect(result).to be(true)
      end
    end

    context 'when white kingside castling is not available' do
      subject(:auxiliary_position_data_no_white_kingside) do
        described_class.from_fen_parser(fen_parser_endgame)
      end

      it 'returns false' do
        result = auxiliary_position_data_no_white_kingside.white_kingside_castle_available?
        expect(result).to be(false)
      end
    end
  end

  describe '#white_queenside_castle_available?' do
    context 'when white queenside castling is available' do
      subject(:auxiliary_position_data_white_queenside) do
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'returns true' do
        result = auxiliary_position_data_white_queenside.white_queenside_castle_available?
        expect(result).to be(true)
      end
    end

    context 'when white queenside castling is not available' do
      subject(:auxiliary_position_data_no_white_queenside) do
        described_class.from_fen_parser(fen_parser_endgame)
      end

      it 'returns false' do
        result = auxiliary_position_data_no_white_queenside.white_queenside_castle_available?
        expect(result).to be(false)
      end
    end
  end

  describe '#black_kingside_castle_available?' do
    context 'when black kingside castling is available' do
      subject(:auxiliary_position_data_black_kingside) do
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'returns true' do
        result = auxiliary_position_data_black_kingside.black_kingside_castle_available?
        expect(result).to be(true)
      end
    end

    context 'when black kingside castling is not available' do
      subject(:auxiliary_position_data_no_black_kingside) do
        described_class.from_fen_parser(fen_parser_endgame)
      end

      it 'returns false' do
        result = auxiliary_position_data_no_black_kingside.black_kingside_castle_available?
        expect(result).to be(false)
      end
    end
  end

  describe '#black_queenside_castle_available?' do
    context 'when black queenside castling is available' do
      subject(:auxiliary_position_data_black_queenside) do
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'returns true' do
        result = auxiliary_position_data_black_queenside.black_queenside_castle_available?
        expect(result).to be(true)
      end
    end

    context 'when black queenside castling is not available' do
      subject(:auxiliary_position_data_no_black_queenside) do
        described_class.from_fen_parser(fen_parser_endgame)
      end

      it 'returns false' do
        result = auxiliary_position_data_no_black_queenside.black_queenside_castle_available?
        expect(result).to be(false)
      end
    end
  end

  describe '#remove_white_kingside_castling_availability' do
    context 'when white kingside castling is available' do
      subject(:auxiliary_position_data_white_kingside) do
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'removes white kingside castling availability' do
        auxiliary_position_data_white_kingside.remove_white_kingside_castling_availability
        data_fields = auxiliary_position_data_white_kingside.instance_variable_get(:@data_fields)
        altered_castling_availability = data_fields[:castling_availability]
        expect(altered_castling_availability).to eq('Qkq')
      end
    end

    context 'when white kingside castling is not available' do
      subject(:auxiliary_position_data_no_white_kingside) do
        described_class.from_fen_parser(fen_parser_endgame)
      end

      it 'returns nil' do
        result = auxiliary_position_data_no_white_kingside.remove_white_kingside_castling_availability
        expect(result).to be_nil
      end
    end
  end

  describe '#remove_white_queenside_castling_availability' do
    context 'when white queenside castling is available' do
      subject(:auxiliary_position_data_white_queenside) do
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'removes white queenside castling availability' do
        auxiliary_position_data_white_queenside.remove_white_queenside_castling_availability
        data_fields = auxiliary_position_data_white_queenside.instance_variable_get(:@data_fields)
        altered_castling_availability = data_fields[:castling_availability]
        expect(altered_castling_availability).to eq('Kkq')
      end
    end

    context 'when white queenside castling is not available' do
      subject(:auxiliary_position_data_no_white_queenside) do
        described_class.from_fen_parser(fen_parser_endgame)
      end

      it 'returns nil' do
        result = auxiliary_position_data_no_white_queenside.remove_white_queenside_castling_availability
        expect(result).to be_nil
      end
    end
  end

  describe '#remove_black_kingside_castling_availability' do
    context 'when black kingside castling is available' do
      subject(:auxiliary_position_data_black_kingside) do
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'removes black kingside castling availability' do
        auxiliary_position_data_black_kingside.remove_black_kingside_castling_availability
        data_fields = auxiliary_position_data_black_kingside.instance_variable_get(:@data_fields)
        altered_castling_availability = data_fields[:castling_availability]
        expect(altered_castling_availability).to eq('KQq')
      end
    end

    context 'when black kingside castling is not available' do
      subject(:auxiliary_position_data_no_black_kingside) do
        described_class.from_fen_parser(fen_parser_endgame)
      end

      it 'returns nil' do
        result = auxiliary_position_data_no_black_kingside.remove_black_kingside_castling_availability
        expect(result).to be_nil
      end
    end
  end

  describe '#remove_black_queenside_castling_availability' do
    context 'when black queenside castling is available' do
      subject(:auxiliary_position_data_black_queenside) do
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'removes black queenside castling availability' do
        auxiliary_position_data_black_queenside.remove_black_queenside_castling_availability
        data_fields = auxiliary_position_data_black_queenside.instance_variable_get(:@data_fields)
        altered_castling_availability = data_fields[:castling_availability]
        expect(altered_castling_availability).to eq('KQk')
      end
    end

    context 'when black queenside castling is not available' do
      subject(:auxiliary_position_data_no_black_queenside) do
        described_class.from_fen_parser(fen_parser_endgame)
      end

      it 'returns nil' do
        result = auxiliary_position_data_no_black_queenside.remove_black_queenside_castling_availability
        expect(result).to be_nil
      end
    end
  end

  describe '#en_passant_target_available?' do
    context 'when an en passant target is available' do
      subject(:auxiliary_position_data_en_passant) do
        described_class.new(en_passant_data_fields)
      end

      let(:en_passant_data_fields) do
        { active_color: 'b',
          castling_availability: 'KQkq',
          en_passant_target: 'e3',
          half_move_clock: '0',
          full_move_number: '1' }
      end

      it 'returns true' do
        result = auxiliary_position_data_en_passant.en_passant_target_available?
        expect(result).to be(true)
      end
    end

    context 'when an en passant target is not available' do
      subject(:auxiliary_position_data_no_en_passant) do
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'returns false' do
        result = auxiliary_position_data_no_en_passant.en_passant_target_available?
        expect(result).to be(false)
      end
    end
  end

  describe '#access_en_passant_target_coords' do
    context 'when an en passant target is available' do
      subject(:auxiliary_position_data_en_passant) do
        described_class.new(en_passant_data_fields)
      end

      let(:en_passant_data_fields) do
        { active_color: 'b',
          castling_availability: 'KQkq',
          en_passant_target: 'e3',
          half_move_clock: '0',
          full_move_number: '1' }
      end

      it 'returns the en passant target coordinates' do
        result = auxiliary_position_data_en_passant.access_en_passant_target_coords
        expect(result).to eq('e3')
      end
    end

    context 'when an en passant target is not available' do
      subject(:auxiliary_position_data_no_en_passant) do
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'returns nil' do
        result = auxiliary_position_data_no_en_passant.access_en_passant_target_coords
        expect(result).to be_nil
      end
    end
  end

  describe '#fifty_move_rule_satisfied?' do
    context 'when the half move clock is at one hundred' do
      subject(:auxiliary_position_data_fifty_move_rule) do
        described_class.new(half_move_clock_one_hundred_data_fields)
      end

      let(:half_move_clock_one_hundred_data_fields) do
        { active_color: 'b',
          castling_availability: '-',
          en_passant_target: '-',
          half_move_clock: '100',
          full_move_number: '65' }
      end

      it 'returns true' do
        result = auxiliary_position_data_fifty_move_rule.fifty_move_rule_satisfied?
        expect(result).to be(true)
      end
    end

    context 'when the half move clock is at greater than one hundred' do
      subject(:auxiliary_position_data_fifty_move_rule) do
        described_class.new(half_move_clock_one_hundred_and_one_data_fields)
      end

      let(:half_move_clock_one_hundred_and_one_data_fields) do
        { active_color: 'b',
          castling_availability: '-',
          en_passant_target: '-',
          half_move_clock: '101',
          full_move_number: '65' }
      end

      it 'returns true' do
        result = auxiliary_position_data_fifty_move_rule.fifty_move_rule_satisfied?
        expect(result).to be(true)
      end
    end

    context 'when the half move clock is at less than one hundred' do
      subject(:auxiliary_position_data_no_fifty_move_rule) do
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'returns false' do
        result = auxiliary_position_data_no_fifty_move_rule.fifty_move_rule_satisfied?
        expect(result).to be(false)
      end
    end
  end

  describe '#seventy_five_move_rule_satisfied?' do
    context 'when the half move clock is at one hundred and fifty' do
      subject(:auxiliary_position_data_seventy_five_move_rule) do
        described_class.new(half_move_clock_one_hundred_and_fifty_data_fields)
      end

      let(:half_move_clock_one_hundred_and_fifty_data_fields) do
        { active_color: 'b',
          castling_availability: '-',
          en_passant_target: '-',
          half_move_clock: '150',
          full_move_number: '165' }
      end

      it 'returns true' do
        result = auxiliary_position_data_seventy_five_move_rule.seventy_five_move_rule_satisfied?
        expect(result).to be(true)
      end
    end

    context 'when the half move clock is at greater than one hundred and fifty' do
      subject(:auxiliary_position_data_seventy_five_move_rule) do
        described_class.new(half_move_clock_one_hundred_and_fifty_one_data_fields)
      end

      let(:half_move_clock_one_hundred_and_fifty_one_data_fields) do
        { active_color: 'b',
          castling_availability: '-',
          en_passant_target: '-',
          half_move_clock: '151',
          full_move_number: '165' }
      end

      it 'returns true' do
        result = auxiliary_position_data_seventy_five_move_rule.seventy_five_move_rule_satisfied?
        expect(result).to be(true)
      end
    end

    context 'when the half move clock is at less than one hundred and fifty' do
      subject(:auxiliary_position_data_no_seventy_five_move_rule) do
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'returns false' do
        result = auxiliary_position_data_no_seventy_five_move_rule.seventy_five_move_rule_satisfied?
        expect(result).to be(false)
      end
    end
  end

  describe '#increment_half_move_clock' do
    subject(:auxiliary_position_data_default) do
      described_class.from_fen_parser(fen_parser_default)
    end

    it 'increments the half move clock by one' do
      auxiliary_position_data_default.increment_half_move_clock
      data_fields = auxiliary_position_data_default.instance_variable_get(:@data_fields)
      incremented = data_fields[:half_move_clock]
      expect(incremented).to eq('1')
    end
  end

  describe '#reset_half_move_clock' do
    subject(:auxiliary_position_data_half_move_greater_than_zero) do
      described_class.new(half_move_clock_twenty_five_data_fields)
    end

    let(:half_move_clock_twenty_five_data_fields) do
      { active_color: 'b',
        castling_availability: '-',
        en_passant_target: '-',
        half_move_clock: '25',
        full_move_number: '35' }
    end

    it 'resets the half move clock to zero' do
      auxiliary_position_data_half_move_greater_than_zero.reset_half_move_clock
      data_fields = auxiliary_position_data_half_move_greater_than_zero.instance_variable_get(:@data_fields)
      reset = data_fields[:half_move_clock]
      expect(reset).to eq('0')
    end
  end

  describe '#increment_full_move_number' do
    subject(:auxiliary_position_data_default) do
      described_class.from_fen_parser(fen_parser_default)
    end

    it 'increments the full move number by one' do
      auxiliary_position_data_default.increment_full_move_number
      data_fields = auxiliary_position_data_default.instance_variable_get(:@data_fields)
      incremented = data_fields[:full_move_number]
      expect(incremented).to eq('2')
    end
  end
end
