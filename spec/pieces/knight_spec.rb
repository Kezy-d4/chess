# frozen_string_literal: true

require_relative '../../lib/pieces/knight'

describe Knight do
  describe '#generate_adjacent_coords' do
    subject(:knight) { described_class.new(:white) }

    context 'when passed coordinates a8' do
      let(:expected) do
        { south_eastern_one: 'b6',
          south_eastern_two: 'c7' }
      end

      it 'returns a hash of the knight\'s in bounds adjacent coordinates per direction' do
        algebraic_a8 = 'a8'
        result = knight.generate_adjacent_coords(algebraic_a8)
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates e4' do
      let(:expected) do
        { north_western_one: 'c5',
          north_western_two: 'd6',
          north_eastern_one: 'f6',
          north_eastern_two: 'g5',
          south_eastern_one: 'f2',
          south_eastern_two: 'g3',
          south_western_one: 'c3',
          south_western_two: 'd2' }
      end

      it 'returns a hash of the knight\'s in bounds adjacent coordinates per direction' do
        algebraic_e4 = 'e4'
        result = knight.generate_adjacent_coords(algebraic_e4)
        expect(result).to eq(expected)
      end
    end
  end

  describe '#moves_stepwise?' do
    subject(:knight) { described_class.new(:white) }

    it 'returns false' do
      result = knight.moves_stepwise?
      expect(result).to be(false)
    end
  end
end
