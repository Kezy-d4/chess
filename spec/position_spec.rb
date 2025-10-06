# frozen_string_literal: true

require_relative '../lib/position'

describe Position do
  let(:initial_fen) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }
  let(:initial_position) { described_class.from_fen(initial_fen) }

  describe '#rank_keys' do
    context 'when testing the eighth rank' do
      it 'returns the algebraic keys of the eighth rank' do
        result = described_class.rank_keys(8)
        expect(result).to eq(%i[a8 b8 c8 d8 e8 f8 g8 h8])
      end
    end

    context 'when testing the first rank' do
      it 'returns the algebraic keys of the first rank' do
        result = described_class.rank_keys(1)
        expect(result).to eq(%i[a1 b1 c1 d1 e1 f1 g1 h1])
      end
    end
  end
end
