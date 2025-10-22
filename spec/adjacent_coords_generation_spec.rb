# frozen_string_literal: true

require_relative '../lib/adjacent_coords_generation'

describe AdjacentCoordsGeneration do
  let(:dummy_class) { Class.new { extend AdjacentCoordsGeneration } }

  describe '#generate_stepwise_northern_adjacent_coords' do
    context 'when passed coordinates g1' do
      subject(:algebraic_g1) { 'g1' }

      it 'returns an array of northern adjacent coordinates in stepwise order' do
        result = dummy_class.generate_stepwise_northern_adjacent_coords(algebraic_g1)
        expected = %w[g2 g3 g4 g5 g6 g7 g8]
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates g8' do
      subject(:algebraic_g8) { 'g8' }

      it 'returns an empty array' do
        result = dummy_class.generate_stepwise_northern_adjacent_coords(algebraic_g8)
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_stepwise_southern_adjacent_coords' do
    context 'when passed coordinates a8' do
      subject(:algebraic_a8) { 'a8' }

      it 'returns an array of southern adjacent coordinates in stepwise order' do
        result = dummy_class.generate_stepwise_southern_adjacent_coords(algebraic_a8)
        expected = %w[a7 a6 a5 a4 a3 a2 a1]
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates a1' do
      subject(:algebraic_a1) { 'a1' }

      it 'returns an empty array' do
        result = dummy_class.generate_stepwise_southern_adjacent_coords(algebraic_a1)
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_stepwise_western_adjacent_coords' do
    context 'when passed coordinates h4' do
      subject(:algebraic_h4) { 'h4' }

      it 'returns an array of western adjacent coordinates in stepwise order' do
        result = dummy_class.generate_stepwise_western_adjacent_coords(algebraic_h4)
        expected = %w[g4 f4 e4 d4 c4 b4 a4]
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates a4' do
      subject(:algebraic_a4) { 'a4' }

      it 'returns an empty array' do
        result = dummy_class.generate_stepwise_western_adjacent_coords(algebraic_a4)
        expect(result).to be_empty
      end
    end
  end
end
