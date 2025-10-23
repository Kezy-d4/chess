# frozen_string_literal: true

require_relative '../../lib/pieces/queen'

describe Queen do
  describe '#generate_adjacent_coords' do
    subject(:queen) { described_class.new(:white) }

    context 'when passed coordinates a8' do
      it 'returns an array of the queen\'s adjacent coordinates' do
        algebraic_a8 = 'a8'
        result = queen.generate_adjacent_coords(algebraic_a8)
        expect(result).to match_array(%w[b8 c8 d8 e8 f8 g8 h8
                                         a7 a6 a5 a4 a3 a2 a1
                                         b7 c6 d5 e4 f3 g2 h1])
      end
    end

    context 'when passed coordinates e4' do
      it 'returns an array of the queen\'s adjacent coordinates' do # rubocop:disable RSpec/ExampleLength
        algebraic_e4 = 'e4'
        result = queen.generate_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[e5 e6 e7 e8
                                         e3 e2 e1
                                         d4 c4 b4 a4
                                         f4 g4 h4
                                         d5 c6 b7 a8
                                         f3 g2 h1
                                         d3 c2 b1
                                         f5 g6 h7])
      end
    end
  end
end
