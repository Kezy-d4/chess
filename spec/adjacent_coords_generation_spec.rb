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

  describe '#generate_stepwise_eastern_adjacent_coords' do
    context 'when passed coordinates a8' do
      subject(:algebraic_a8) { 'a8' }

      it 'returns an array of eastern adjacent coordinates in stepwise order' do
        result = dummy_class.generate_stepwise_eastern_adjacent_coords(algebraic_a8)
        expected = %w[b8 c8 d8 e8 f8 g8 h8]
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates h8' do
      subject(:algebraic_h8) { 'h8' }

      it 'returns an empty array' do
        result = dummy_class.generate_stepwise_eastern_adjacent_coords(algebraic_h8)
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_stepwise_north_western_adjacent_coords' do
    context 'when passed coordinates h1' do
      subject(:algebraic_h1) { 'h1' }

      it 'returns an array of north western adjacent coordinates in stepwise order' do
        result = dummy_class.generate_stepwise_north_western_adjacent_coords(algebraic_h1)
        expected = %w[g2 f3 e4 d5 c6 b7 a8]
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates a8' do
      subject(:algebraic_a8) { 'a8' }

      it 'returns an empty array' do
        result = dummy_class.generate_stepwise_north_western_adjacent_coords(algebraic_a8)
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_stepwise_north_eastern_adjacent_coords' do
    context 'when passed coordinates a1' do
      subject(:algebraic_a1) { 'a1' }

      it 'returns an array of north eastern adjacent coordinates in stepwise order' do
        result = dummy_class.generate_stepwise_north_eastern_adjacent_coords(algebraic_a1)
        expected = %w[b2 c3 d4 e5 f6 g7 h8]
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates h8' do
      subject(:algebraic_h8) { 'h8' }

      it 'returns an empty array' do
        result = dummy_class.generate_stepwise_north_eastern_adjacent_coords(algebraic_h8)
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_stepwise_south_western_adjacent_cords' do
    context 'when passed coordinates h8' do
      subject(:algebraic_h8) { 'h8' }

      it 'returns an array of south western adjacent coordinates in stepwise order' do
        result = dummy_class.generate_stepwise_south_western_adjacent_coords(algebraic_h8)
        expected = %w[g7 f6 e5 d4 c3 b2 a1]
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates a1' do
      subject(:algebraic_a1) { 'a1' }

      it 'returns an empty array' do
        result = dummy_class.generate_stepwise_south_western_adjacent_coords(algebraic_a1)
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_stepwise_south_eastern_adjacent_coords' do
    context 'when passed coordinates a8' do
      subject(:algebraic_a8) { 'a8' }

      it 'returns an array of south eastern adjacent coordinates in stepwise order' do
        result = dummy_class.generate_stepwise_south_eastern_adjacent_coords(algebraic_a8)
        expected = %w[b7 c6 d5 e4 f3 g2 h1]
        expect(result).to eq(expected)
      end
    end

    context 'when passed coordinates h1' do
      subject(:algebraic_h1) { 'h1' }

      it 'returns an empty array' do
        result = dummy_class.generate_stepwise_south_eastern_adjacent_coords(algebraic_h1)
        expect(result).to be_empty
      end
    end
  end
end
