# frozen_string_literal: true

require_relative '../../lib/pieces/king'

describe King do
  describe '#generate_adjacent_coords' do
    context 'when the king has coordinates e4' do
      subject(:king_e4) { described_class.new('e4', :white) }

      let(:expected) do
        { n: %w[e5],
          e: %w[f4],
          s: %w[e3],
          w: %w[d4],
          n_e: %w[f5],
          s_e: %w[f3],
          s_w: %w[d3],
          n_w: %w[d5] }
      end

      it 'returns a hash of adjacent coordinates' do
        result = king_e4.generate_adjacent_coords
        expect(result).to eq(expected)
      end
    end

    context 'when the king has coordinates a8' do
      subject(:king_a8) { described_class.new('a8', :white) }

      let(:expected) do
        { s: %w[a7],
          e: %w[b8],
          s_e: %w[b7] }
      end

      it 'returns a hash of adjacent coordinates' do
        result = king_a8.generate_adjacent_coords
        expect(result).to eq(expected)
      end
    end
  end
end
