# frozen_string_literal: true

require_relative '../lib/adjacent_coords_generator'

describe AdjacentCoordsGenerator do
  let(:dummy_class) { Class.new { extend AdjacentCoordsGenerator } }

  describe '#generate_northern_coords' do
    context 'when testing with coordinates e4' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of the in bounds northern coordinates in stepwise order' do
        result = dummy_class.generate_northern_coords(algebraic_e4)
        expect(result).to eq(%w[e5 e6 e7 e8])
      end
    end

    context 'when testing with coordinates e8' do
      subject(:algebraic_e8) { 'e8' }

      it 'returns an empty array' do
        result = dummy_class.generate_northern_coords(algebraic_e8)
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_north_eastern_coords' do
    context 'when testing with coordinates e4' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of the in bounds north eastern coordinates in stepwise order' do
        result = dummy_class.generate_north_eastern_coords(algebraic_e4)
        expect(result).to eq(%w[f5 g6 h7])
      end
    end

    context 'when testing with coordinates h4' do
      subject(:algebraic_h4) { 'h4' }

      it 'returns an empty array' do
        result = dummy_class.generate_north_eastern_coords(algebraic_h4)
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_eastern_coords' do
    context 'when testing with coordinates e4' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of the in bounds eastern coordinates in stepwise order' do
        result = dummy_class.generate_eastern_coords(algebraic_e4)
        expect(result).to eq(%w[f4 g4 h4])
      end
    end

    context 'when testing with coordinates h4' do
      subject(:algebraic_h4) { 'h4' }

      it 'returns an empty array' do
        result = dummy_class.generate_eastern_coords(algebraic_h4)
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_south_eastern_coords' do
    context 'when testing with coordinates e4' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of the in bounds south eastern coordinates in stepwise order' do
        result = dummy_class.generate_south_eastern_coords(algebraic_e4)
        expect(result).to eq(%w[f3 g2 h1])
      end
    end

    context 'when testing with coordinates h4' do
      subject(:algebraic_h4) { 'h4' }

      it 'returns an empty array' do
        result = dummy_class.generate_south_eastern_coords(algebraic_h4)
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_southern_coords' do
    context 'when testing with coordinates e4' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of the in bounds southern coordinates in stepwise order' do
        result = dummy_class.generate_southern_coords(algebraic_e4)
        expect(result).to eq(%w[e3 e2 e1])
      end
    end

    context 'when testing with coordinates e1' do
      subject(:algebraic_e1) { 'e1' }

      it 'returns an empty array' do
        result = dummy_class.generate_southern_coords(algebraic_e1)
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_south_western_coords' do
    context 'when testing with coordinates e4' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of the in bounds south western coordinates in stepwise order' do
        result = dummy_class.generate_south_western_coords(algebraic_e4)
        expect(result).to eq(%w[d3 c2 b1])
      end
    end

    context 'when testing with coordinates a4' do
      subject(:algebraic_a4) { 'a4' }

      it 'returns an empty array' do
        result = dummy_class.generate_south_western_coords(algebraic_a4)
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_western_coords' do
    context 'when testing with coordinates e4' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of the in bounds western coordinates in stepwise order' do
        result = dummy_class.generate_western_coords(algebraic_e4)
        expect(result).to eq(%w[d4 c4 b4 a4])
      end
    end

    context 'when testing with coordinates a4' do
      subject(:algebraic_a4) { 'a4' }

      it 'returns an empty array' do
        result = dummy_class.generate_western_coords(algebraic_a4)
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_north_western_coords' do
    context 'when testing with coordinates e4' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of the in bounds north western coordinates in stepwise order' do
        result = dummy_class.generate_north_western_coords(algebraic_e4)
        expect(result).to eq(%w[d5 c6 b7 a8])
      end
    end

    context 'when testing with coordinates a4' do
      subject(:algebraic_a4) { 'a4' }

      it 'returns an empty array' do
        result = dummy_class.generate_north_western_coords(algebraic_a4)
        expect(result).to be_empty
      end
    end
  end
end
