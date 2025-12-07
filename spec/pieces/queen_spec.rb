# frozen_string_literal: true

require_relative '../../lib/pieces/queen'

describe Queen do
  describe '#generate_adjacent_coords' do
    context 'when the queen has coordinates e4' do
      subject(:queen_e4) { described_class.new('e4', :white) }

      let(:expected) do
        { n: %w[e5 e6 e7 e8],
          e: %w[f4 g4 h4],
          s: %w[e3 e2 e1],
          w: %w[d4 c4 b4 a4],
          n_e: %w[f5 g6 h7],
          s_e: %w[f3 g2 h1],
          s_w: %w[d3 c2 b1],
          n_w: %w[d5 c6 b7 a8] }
      end

      it 'returns a hash of adjacent coordinates' do
        result = queen_e4.generate_adjacent_coords
        expect(result).to eq(expected)
      end
    end

    context 'when the queen has coordinates a8' do
      subject(:queen_a8) { described_class.new('a8', :white) }

      let(:expected) do
        { e: %w[b8 c8 d8 e8 f8 g8 h8],
          s: %w[a7 a6 a5 a4 a3 a2 a1],
          s_e: %w[b7 c6 d5 e4 f3 g2 h1] }
      end

      it 'returns a hash of adjacent coordinates' do
        result = queen_a8.generate_adjacent_coords
        expect(result).to eq(expected)
      end
    end
  end
end
