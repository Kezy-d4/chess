# frozen_string_literal: true

require_relative '../../lib/pieces/king'

describe King do
  describe '#generate_adjacent_coords' do
    subject(:king) { described_class.new(:white) }

    context 'when passed coordinates a8' do
      let(:expected) do
        { eastern: 'b8',
          south_eastern: 'b7',
          southern: 'a7' }
      end

      it 'returns a hash of the king\'s in bounds adjacent coordinates per direction' do
        algebraic_a8 = 'a8'
        result = king.generate_adjacent_coords(algebraic_a8)
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates e4' do
      let(:expected) do
        { northern: 'e5',
          north_eastern: 'f5',
          eastern: 'f4',
          south_eastern: 'f3',
          southern: 'e3',
          south_western: 'd3',
          western: 'd4',
          north_western: 'd5' }
      end

      it 'returns a hash of the king\'s in bounds adjacent coordinates per direction' do
        algebraic_e4 = 'e4'
        result = king.generate_adjacent_coords(algebraic_e4)
        expect(result).to eq(expected)
      end
    end
  end

  describe '#moves_stepwise?' do
    subject(:king) { described_class.new(:white) }

    it 'returns false' do
      result = king.moves_stepwise?
      expect(result).to be(false)
    end
  end
end
