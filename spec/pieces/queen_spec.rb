# frozen_string_literal: true

require_relative '../../lib/pieces/queen'

describe Queen do
  describe '#generate_adjacent_coords' do
    subject(:queen) { described_class.new(:white) }

    context 'when passed coordinates a8' do
      let(:expected) do
        { eastern: %w[b8 c8 d8 e8 f8 g8 h8],
          south_eastern: %w[b7 c6 d5 e4 f3 g2 h1],
          southern: %w[a7 a6 a5 a4 a3 a2 a1] }
      end

      it 'returns a hash of the queen\'s stepwise, in bounds adjacent coordinates per direction' do
        algebraic_a8 = 'a8'
        result = queen.generate_adjacent_coords(algebraic_a8)
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates e4' do
      let(:expected) do
        { northern: %w[e5 e6 e7 e8],
          north_eastern: %w[f5 g6 h7],
          eastern: %w[f4 g4 h4],
          south_eastern: %w[f3 g2 h1],
          southern: %w[e3 e2 e1],
          south_western: %w[d3 c2 b1],
          western: %w[d4 c4 b4 a4],
          north_western: %w[d5 c6 b7 a8] }
      end

      it 'returns a hash of the queen\'s stepwise, in bounds adjacent coordinates per direction' do
        algebraic_e4 = 'e4'
        result = queen.generate_adjacent_coords(algebraic_e4)
        expect(result).to eq(expected)
      end
    end
  end

  describe '#moves_stepwise?' do
    subject(:queen) { described_class.new(:white) }

    it 'returns true' do
      result = queen.moves_stepwise?
      expect(result).to be(true)
    end
  end
end
