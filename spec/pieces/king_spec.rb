# frozen_string_literal: true

require_relative '../../lib/pieces/king'

describe King do
  describe '#generate_adjacent_coords' do
    subject(:king) { described_class.new(:white) }

    context 'when passed coordinates a8' do
      it 'returns an array of the king\'s adjacent coordinates' do
        algebraic_a8 = 'a8'
        result = king.generate_adjacent_coords(algebraic_a8)
        expect(result).to match_array(%w[a7 b7 b8])
      end
    end

    context 'when passed coordinates e4' do
      it 'returns an array of the king\'s adjacent coordinates' do
        algebraic_e4 = 'e4'
        result = king.generate_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[d5 e5 f5 d4 f4 d3 e3 f3])
      end
    end
  end
end
