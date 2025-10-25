# frozen_string_literal: true

require_relative '../../lib/pieces/rook'

describe Rook do
  describe '#generate_adjacent_coords' do
    subject(:rook) { described_class.new(:white) }

    context 'when passed coordinates a8' do
      let(:expected) do
        { eastern: %w[b8 c8 d8 e8 f8 g8 h8],
          southern: %w[a7 a6 a5 a4 a3 a2 a1] }
      end

      it 'returns a hash of the rook\'s stepwise, in bounds adjacent coordinates per direction' do
        algebraic_a8 = 'a8'
        result = rook.generate_adjacent_coords(algebraic_a8)
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates e4' do
      let(:expected) do
        { northern: %w[e5 e6 e7 e8],
          eastern: %w[f4 g4 h4],
          southern: %w[e3 e2 e1],
          western: %w[d4 c4 b4 a4] }
      end

      it 'returns a hash of the rook\'s stepwise, in bounds adjacent coordinates per direction' do
        algebraic_e4 = 'e4'
        result = rook.generate_adjacent_coords(algebraic_e4)
        expect(result).to eq(expected)
      end
    end
  end
end
