# frozen_string_literal: true

require_relative '../../lib/pieces/rook'

describe Rook do
  describe '#generate_adjacent_coords' do
    subject(:rook) { described_class.new(:white) }

    context 'when passed coordinates a8' do
      it 'returns an array of the rook\'s adjacent coordinates' do
        algebraic_a8 = 'a8'
        result = rook.generate_adjacent_coords(algebraic_a8)
        expect(result).to match_array(%w[a7 a6 a5 a4 a3 a2 a1
                                         b8 c8 d8 e8 f8 g8 h8])
      end
    end

    context 'when passed coordinates e4' do
      it 'returns an array of the rook\'s adjacent coordinates' do # rubocop:disable RSpec/ExampleLength
        algebraic_e4 = 'e4'
        result = rook.generate_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[e3 e2 e1
                                         e5 e6 e7 e8
                                         d4 c4 b4 a4
                                         f4 g4 h4])
      end
    end
  end
end
