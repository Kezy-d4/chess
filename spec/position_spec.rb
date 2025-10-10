# frozen_string_literal: true

require_relative '../lib/position'

describe Position do
  let(:initial_fen) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }
  let(:position_initial) { described_class.from_fen(initial_fen) }

  describe '#rank_keys' do
    context 'when testing the eighth rank' do
      it 'returns the algebraic keys of the eighth rank' do
        rank = 8
        result = described_class.rank_keys(rank)
        expect(result).to eq(%i[a8 b8 c8 d8 e8 f8 g8 h8])
      end
    end

    context 'when testing the first rank' do
      it 'returns the algebraic keys of the first rank' do
        rank = 1
        result = described_class.rank_keys(rank)
        expect(result).to eq(%i[a1 b1 c1 d1 e1 f1 g1 h1])
      end
    end

    context 'when testing an invalid argument' do
      it 'raises an error' do
        invalid_rank = 0
        expect { described_class.rank_keys(invalid_rank) }.to raise_error(ArgumentError)
      end
    end
  end
end
