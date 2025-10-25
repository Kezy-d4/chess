# frozen_string_literal: true

require_relative '../../lib/pieces/bishop'

describe Bishop do
  describe '#generate_adjacent_coords' do
    subject(:bishop) { described_class.new(:white) }

    context 'when passed coordinates a8' do
      let(:expected) do
        { south_eastern: %w[b7 c6 d5 e4 f3 g2 h1] }
      end

      it 'returns a hash of the bishop\'s stepwise, in bounds adjacent coordinates per direction' do
        algebraic_a8 = 'a8'
        result = bishop.generate_adjacent_coords(algebraic_a8)
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates e4' do
      let(:expected) do
        { north_eastern: %w[f5 g6 h7],
          south_eastern: %w[f3 g2 h1],
          south_western: %w[d3 c2 b1],
          north_western: %w[d5 c6 b7 a8] }
      end

      it 'returns a hash of the bishop\'s stepwise, in bounds adjacent coordinates per direction' do
        algebraic_e4 = 'e4'
        result = bishop.generate_adjacent_coords(algebraic_e4)
        expect(result).to eq(expected)
      end
    end
  end
end
