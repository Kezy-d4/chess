# frozen_string_literal: true

require_relative '../lib/fen_separation'

describe FenSeparation do
  context 'when the fen record represents the initial chess position' do
    subject(:fen_str) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }

    let(:dummy_class) { Class.new { extend FenSeparation } }

    describe '#piece_placement_data' do
      it 'returns a substring containing just the piece placement data field' do
        result = dummy_class.piece_placement_data(fen_str)
        expected = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR'
        expect(result).to eq(expected)
      end
    end

    describe '#active_color_data' do
      it 'returns a substring containing just the active color data field' do
        result = dummy_class.active_color_data(fen_str)
        expected = 'w'
        expect(result).to eq(expected)
      end
    end

    describe '#castling_rights_data' do
      it 'returns a substring containing just the castling rights data field' do
        result = dummy_class.castling_rights_data(fen_str)
        expected = 'KQkq'
        expect(result).to eq(expected)
      end
    end

    describe '#en_passant_target_square_data' do
      it 'returns a substring containing just the en passant target square data field' do
        result = dummy_class.en_passant_target_square_data(fen_str)
        expected = '-'
        expect(result).to eq(expected)
      end
    end

    describe '#half_move_clock_data' do
      it 'returns a substring containing just the half move clock data field' do
        result = dummy_class.half_move_clock_data(fen_str)
        expected = '0'
        expect(result).to eq(expected)
      end
    end

    describe '#full_move_number_data' do
      it 'returns a substring containing just the full move number data field' do
        result = dummy_class.full_move_number_data(fen_str)
        expected = '1'
        expect(result).to eq(expected)
      end
    end

    describe '#piece_placement_data_by_rank' do
      it 'returns a substring containing just the piece placement data of the eighth rank' do
        rank_num = 8
        result = dummy_class.piece_placement_data_by_rank(fen_str, rank_num)
        expected = 'rnbqkbnr'
        expect(result).to eq(expected)
      end

      it 'returns a substring containing just the piece placement data of the first rank' do
        rank_num = 1
        result = dummy_class.piece_placement_data_by_rank(fen_str, rank_num)
        expected = 'RNBQKBNR'
        expect(result).to eq(expected)
      end

      it 'returns a substring containing just the piece placement data of the sixth rank' do
        rank_num = 6
        result = dummy_class.piece_placement_data_by_rank(fen_str, rank_num)
        expected = '8'
        expect(result).to eq(expected)
      end

      it 'returns a substring containing just the piece placement data of the third rank' do
        rank_num = 3
        result = dummy_class.piece_placement_data_by_rank(fen_str, rank_num)
        expected = '8'
        expect(result).to eq(expected)
      end
    end
  end
end
