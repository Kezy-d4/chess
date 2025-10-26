# frozen_string_literal: true

require_relative '../../lib/pieces/pawn'

describe Pawn do
  describe '#generate_adjacent_coords' do
    context 'when passed coordinates a7 and the pawn is white' do
      subject(:pawn_white) { described_class.new(:white) }

      let(:expected) do
        { north_eastern: 'b8' }
      end

      it 'returns a hash of the pawn\'s in bounds adjacent coordinates per direction' do
        algebraic_a7 = 'a7'
        result = pawn_white.generate_adjacent_coords(algebraic_a7)
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates b7 and the pawn is white' do
      subject(:pawn_white) { described_class.new(:white) }

      let(:expected) do
        { north_western: 'a8',
          north_eastern: 'c8' }
      end

      it 'returns a hash of the pawn\'s in bounds adjacent coordinates per direction' do
        algebraic_b7 = 'b7'
        result = pawn_white.generate_adjacent_coords(algebraic_b7)
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates a8 and the pawn is white' do
      subject(:pawn_white) { described_class.new(:white) }

      it 'return an empty hash' do
        algebraic_a8 = 'a8'
        result = pawn_white.generate_adjacent_coords(algebraic_a8)
        expect(result).to be_empty
      end
    end

    context 'when passed coordinates a2 and the pawn is black' do
      subject(:pawn_black) { described_class.new(:black) }

      let(:expected) do
        { south_eastern: 'b1' }
      end

      it 'returns a hash of the pawn\'s in bounds adjacent coordinates per direction' do
        algebraic_a2 = 'a2'
        result = pawn_black.generate_adjacent_coords(algebraic_a2)
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates b2 and the pawn is black' do
      subject(:pawn_black) { described_class.new(:black) }

      let(:expected) do
        { south_western: 'a1',
          south_eastern: 'c1' }
      end

      it 'returns a hash of the pawn\'s in bounds adjacent coordinates per direction' do
        algebraic_b2 = 'b2'
        result = pawn_black.generate_adjacent_coords(algebraic_b2)
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates a1 and the pawn is black' do
      subject(:pawn_black) { described_class.new(:black) }

      it 'returns an empty hash' do
        algebraic_a1 = 'a1'
        result = pawn_black.generate_adjacent_coords(algebraic_a1)
        expect(result).to be_empty
      end
    end
  end

  describe '#moves_stepwise?' do
    subject(:pawn) { described_class.new(:white) }

    it 'returns false' do
      result = pawn.moves_stepwise?
      expect(result).to be(false)
    end
  end
end
