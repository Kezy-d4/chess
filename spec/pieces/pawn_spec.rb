# frozen_string_literal: true

require_relative '../../lib/pieces/pawn'

describe Pawn do
  describe '#generate_adjacent_coords' do
    context 'when the pawn is white' do
      subject(:pawn_white) { described_class.new(:white) }

      it 'returns an array of the pawn\'s adjacent coordinates when passed coordinates a7' do
        algebraic_a7 = 'a7'
        result = pawn_white.generate_adjacent_coords(algebraic_a7)
        expect(result).to match_array(%w[b8])
      end

      it 'returns an array of the pawn\'s adjacent coordinates when passed coordinates b7' do
        algebraic_b7 = 'b7'
        result = pawn_white.generate_adjacent_coords(algebraic_b7)
        expect(result).to match_array(%w[a8 c8])
      end

      it 'return an empty array when passed coordinates a8' do
        algebraic_a8 = 'a8'
        result = pawn_white.generate_adjacent_coords(algebraic_a8)
        expect(result).to be_empty
      end
    end

    context 'when the pawn is black' do
      subject(:pawn_black) { described_class.new(:black) }

      it 'returns an array of the pawn\'s adjacent coordinates when passed coordinates a2' do
        algebraic_a2 = 'a2'
        result = pawn_black.generate_adjacent_coords(algebraic_a2)
        expect(result).to match_array(%w[b1])
      end

      it 'returns an array of the pawn\'s adjacent coordinates when passed coordinates b2' do
        algebraic_b2 = 'b2'
        result = pawn_black.generate_adjacent_coords(algebraic_b2)
        expect(result).to match_array(%w[a1 c1])
      end

      it 'returns an empty array when passed coordinates a1' do
        algebraic_a1 = 'a1'
        result = pawn_black.generate_adjacent_coords(algebraic_a1)
        expect(result).to be_empty
      end
    end
  end
end
