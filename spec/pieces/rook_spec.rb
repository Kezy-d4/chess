# frozen_string_literal: true

require_relative '../../lib/pieces/rook'

describe Rook do
  describe '#generate_adjacent_coords' do
    context 'when the rook has coordinates e4' do
      subject(:rook_e4) { described_class.new('e4', :white) }

      let(:expected) do
        { n: %w[e5 e6 e7 e8],
          e: %w[f4 g4 h4],
          s: %w[e3 e2 e1],
          w: %w[d4 c4 b4 a4] }
      end

      it 'returns a hash of adjacent coordinates' do
        result = rook_e4.generate_adjacent_coords
        expect(result).to eq(expected)
      end
    end

    context 'when the rook has coordinates a8' do
      subject(:rook_a8) { described_class.new('a8', :white) }

      let(:expected) do
        { e: %w[b8 c8 d8 e8 f8 g8 h8],
          s: %w[a7 a6 a5 a4 a3 a2 a1] }
      end

      it 'returns a hash of adjacent coordinates' do
        result = rook_a8.generate_adjacent_coords
        expect(result).to eq(expected)
      end
    end
  end
end
