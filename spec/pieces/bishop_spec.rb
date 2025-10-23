# frozen_string_literal: true

require_relative '../../lib/pieces/bishop'

describe Bishop do
  describe '#generate_adjacent_coords' do
    subject(:bishop) { described_class.new(:white) }

    context 'when passed coordinates a8' do
      it 'returns an array of the bishop\'s adjacent coordinates' do
        algebraic_a8 = 'a8'
        result = bishop.generate_adjacent_coords(algebraic_a8)
        expect(result).to match_array(%w[b7 c6 d5 e4 f3 g2 h1])
      end
    end

    context 'when passed coordinates e4' do
      it 'returns an array of the bishop\'s adjacent coordinates' do # rubocop:disable RSpec/ExampleLength
        algebraic_e4 = 'e4'
        result = bishop.generate_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[d5 c6 b7 a8
                                         f5 g6 h7
                                         d3 c2 b1
                                         f3 g2 h1])
      end
    end
  end
end
