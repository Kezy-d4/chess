# frozen_string_literal: true

require_relative '../../lib/pieces/knight'

describe Knight do
  describe '#generate_adjacent_coords' do
    subject(:knight) { described_class.new(:white) }

    context 'when passed coordinates a8' do
      it 'returns an array of the knight\'s in bounds adjacent coordinates' do
        algebraic_a8 = 'a8'
        result = knight.generate_adjacent_coords(algebraic_a8)
        expect(result).to match_array(%w[b6 c7])
      end
    end

    context 'when passed coordinates e4' do
      it 'returns an array of the knight\'s in bounds adjacent coordinates' do # rubocop:disable RSpec/ExampleLength
        algebraic_e4 = 'e4'
        result = knight.generate_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[c5 d6
                                         f6 g5
                                         c3 d2
                                         g3 f2])
      end
    end
  end
end
