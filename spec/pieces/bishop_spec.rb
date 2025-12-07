# frozen_string_literal: true

require_relative '../../lib/pieces/bishop'

describe Bishop do
  describe '#generate_adjacent_coords' do
    context 'when the bishop has coordinates e4' do
      subject(:bishop_e4) { described_class.new('e4', :white) }

      let(:expected) do
        { n_e: %w[f5 g6 h7],
          s_e: %w[f3 g2 h1],
          s_w: %w[d3 c2 b1],
          n_w: %w[d5 c6 b7 a8] }
      end

      it 'returns a hash of adjacent coordinates' do
        result = bishop_e4.generate_adjacent_coords
        expect(result).to eq(expected)
      end
    end

    context 'when the bishop has coordinates a8' do
      subject(:bishop_a8) { described_class.new('a8', :white) }

      let(:expected) { { s_e: %w[b7 c6 d5 e4 f3 g2 h1] } }

      it 'returns a hash of adjacent coordinates' do
        result = bishop_a8.generate_adjacent_coords
        expect(result).to eq(expected)
      end
    end
  end
end
