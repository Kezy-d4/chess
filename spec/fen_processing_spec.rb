# frozen_string_literal: true

require_relative '../lib/fen_processing'

describe FenProcessing do
  let(:dummy_class) { Class.new { extend FenProcessing } }
  let(:initial_fen) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }

  describe '#data_fields' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns an array of substrings representing each data field' do
        result = dummy_class.data_fields(initial_fen)
        expected = ['rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR', 'w', 'KQkq', '-', '0', '1']
        expect(result).to eq(expected)
      end
    end
  end

  describe '#piece_placement_data' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns a substring representing the piece placement data field' do
        result = dummy_class.piece_placement_data(initial_fen)
        expected = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#active_color_data' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns a substring representing the active color data field' do
        result = dummy_class.active_color_data(initial_fen)
        expected = 'w'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#castling_rights_data' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns a substring representing the castling rights data field' do
        result = dummy_class.castling_rights_data(initial_fen)
        expected = 'KQkq'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#en_passant_target_square_data' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns a substring representing the en passant target square data field' do
        result = dummy_class.en_passant_target_square_data(initial_fen)
        expected = '-'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#half_move_clock_data' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns a substring representing the half move clock data field' do
        result = dummy_class.half_move_clock_data(initial_fen)
        expected = '0'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#full_move_number_data' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns a substring representing the full move number data field' do
        result = dummy_class.full_move_number_data(initial_fen)
        expected = '1'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#piece_placement_data_of_ranks' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns an array of substrings representing the piece placement data of each rank' do
        result = dummy_class.piece_placement_data_of_ranks(initial_fen)
        expected = %w[rnbqkbnr pppppppp 8 8 8 8 PPPPPPPP RNBQKBNR]
        expect(result).to eq(expected)
      end
    end
  end

  describe '#piece_placement_data_by_rank' do
    context 'when the FEN record represents the initial chess position' do
      subject { initial_fen }

      it 'returns a substring representing the piece placement data of the eighth rank' do
        rank = 8
        result = dummy_class.piece_placement_data_by_rank(initial_fen, rank)
        expected = 'rnbqkbnr'
        expect(result).to eq(expected)
      end

      it 'returns a substring representing the piece placement data of the sixth rank' do
        rank = 6
        result = dummy_class.piece_placement_data_by_rank(initial_fen, rank)
        expected = '8'
        expect(result).to eq(expected)
      end

      it 'returns a substring representing the piece placement data of the third rank' do
        rank = 3
        result = dummy_class.piece_placement_data_by_rank(initial_fen, rank)
        expected = '8'
        expect(result).to eq(expected)
      end

      it 'returns a substring representing the piece placement data of the second rank' do
        rank = 2
        result = dummy_class.piece_placement_data_by_rank(initial_fen, rank)
        expected = 'PPPPPPPP'
        expect(result).to eq(expected)
      end
    end
  end
end
