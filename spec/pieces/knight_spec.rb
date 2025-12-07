# frozen_string_literal: true

require_relative '../../lib/pieces/knight'

describe Knight do
  describe '#generate_adjacent_coords' do
    context 'when the knight has coordinates e4' do
      subject(:knight_e4) { described_class.new('e4', :white) }

      let(:expected) do
        { n_e_l: ['f6'],
          n_e_r: ['g5'],
          s_e_l: ['f2'],
          s_e_r: ['g3'],
          s_w_l: ['c3'],
          s_w_r: ['d2'],
          n_w_l: ['c5'],
          n_w_r: ['d6'] }
      end

      it 'returns a hash of adjacent coordinates' do
        result = knight_e4.generate_adjacent_coords
        expect(result).to eq(expected)
      end
    end

    context 'when the knight has coordinates a8' do
      subject(:knight_a8) { described_class.new('a8', :white) }

      let(:expected) do
        { s_e_l: ['b6'],
          s_e_r: ['c7'] }
      end

      it 'returns a hash of adjacent coordinates' do
        result = knight_a8.generate_adjacent_coords
        expect(result).to eq(expected)
      end
    end
  end
end
