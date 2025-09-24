# frozen_string_literal: true

require_relative '../lib/position_generation'

describe PositionGeneration do
  context 'when the fen record represents the initial chess position' do
    subject(:fen_str) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }

    let(:dummy_class) { Class.new { extend PositionGeneration } }

    describe '#position_from_fen' do
      let(:expected) do
        [%w[r n b q k b n r],
         %w[p p p p p p p p],
         [nil, nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil, nil, nil],
         %w[P P P P P P P P],
         %w[R N B Q K B N R]]
      end

      it 'returns each rank of the fen record translated into a nested array' do
        result = dummy_class.position_from_fen(fen_str)
        expect(result).to eq(expected)
      end
    end

    describe '#position_from_fen_by_rank' do
      it 'returns the eighth rank of the fen record translated into an array' do
        rank_num = 8
        result = dummy_class.position_from_fen_by_rank(fen_str, rank_num)
        expected = %w[r n b q k b n r]
        expect(result).to eq(expected)
      end

      it 'returns the first rank of the fen record translated into an array' do
        rank_num = 1
        result = dummy_class.position_from_fen_by_rank(fen_str, rank_num)
        expected = %w[R N B Q K B N R]
        expect(result).to eq(expected)
      end

      it 'returns the sixth rank of the fen record translated into an array' do
        rank_num = 6
        result = dummy_class.position_from_fen_by_rank(fen_str, rank_num)
        expected = [nil, nil, nil, nil, nil, nil, nil, nil]
        expect(result).to eq(expected)
      end

      it 'returns the third rank of the fen record translated into an array' do
        rank_num = 3
        result = dummy_class.position_from_fen_by_rank(fen_str, rank_num)
        expected = [nil, nil, nil, nil, nil, nil, nil, nil]
        expect(result).to eq(expected)
      end
    end
  end
end
