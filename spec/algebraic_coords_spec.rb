# frozen_string_literal: true

require_relative '../lib/algebraic_coords'

describe AlgebraicCoords do
  describe '::from_s' do
    subject { described_class }

    context 'when testing with coordinates a8 as a string' do
      let(:algebraic_string_a8) { 'a8' }

      it 'returns an AlgebraicCoords object with the expected file coordinate' do
        result = described_class.from_s(algebraic_string_a8)
        file = result.instance_variable_get(:@file)
        expect(file).to eq('a')
      end

      it 'returns an AlgebraicCoords object with the expected rank coordinate' do
        result = described_class.from_s(algebraic_string_a8)
        rank = result.instance_variable_get(:@rank)
        expect(rank).to eq(8)
      end
    end
  end

  describe '#to_adjacency' do
    subject(:algebraic_coords_a8) { described_class.new('a', 8) }

    context 'when the file and rank adjustments are both zero' do
      it 'raises an ArgumentError' do
        file_adjustment = 0
        rank_adjustment = 0
        expect { algebraic_coords_a8.to_adjacency(file_adjustment, rank_adjustment) }.to \
          raise_error(ArgumentError)
      end
    end

    context 'when the coordinates would fall out of bounds post adjustment' do
      it 'raises an ArgumentError' do
        file_adjustment = -1
        rank_adjustment = 1
        expect { algebraic_coords_a8.to_adjacency(file_adjustment, rank_adjustment) }.to \
          raise_error(ArgumentError)
      end
    end

    context 'when the coordinates would remain in bounds post adjustment' do
      let(:file_adjustment) { 1 }
      let(:rank_adjustment) { -1 }

      it 'returns an AlgebraicCoords object with the adjusted file coordinate' do
        result = algebraic_coords_a8.to_adjacency(file_adjustment, rank_adjustment)
        file = result.instance_variable_get(:@file)
        expect(file).to eq('b')
      end

      it 'returns an AlgebraicCoords object with the adjusted rank coordinate' do
        result = algebraic_coords_a8.to_adjacency(file_adjustment, rank_adjustment)
        rank = result.instance_variable_get(:@rank)
        expect(rank).to eq(7)
      end
    end
  end

  describe '#to_northern_adjacencies' do
    context 'when testing with coordinates a1' do
      subject(:algebraic_coords_a1) { described_class.new('a', 1) }

      it 'returns an array of northern adjacencies in order from the source' do
        result = algebraic_coords_a1.to_northern_adjacencies
        strings = result.map(&:to_s)
        expect(strings).to eq(%w[a2 a3 a4 a5 a6 a7 a8])
      end
    end

    context 'when testing with coordinates a8' do
      subject(:algebraic_coords_a8) { described_class.new('a', 8) }

      it 'returns an empty array' do
        result = algebraic_coords_a8.to_northern_adjacencies
        expect(result).to be_an(Array).and be_empty
      end
    end
  end

  describe '#to_eastern_adjacencies' do
    context 'when testing with coordinates a8' do
      subject(:algebraic_coords_a8) { described_class.new('a', 8) }

      it 'returns an array of eastern adjacencies in order from the source' do
        result = algebraic_coords_a8.to_eastern_adjacencies
        strings = result.map(&:to_s)
        expect(strings).to eq(%w[b8 c8 d8 e8 f8 g8 h8])
      end
    end

    context 'when testing with coordinates h8' do
      subject(:algebraic_coords_h8) { described_class.new('h', 8) }

      it 'returns an empty array' do
        result = algebraic_coords_h8.to_eastern_adjacencies
        expect(result).to be_an(Array).and be_empty
      end
    end
  end

  describe '#to_southern_adjacencies' do
    context 'when testing with coordinates a8' do
      subject(:algebraic_coords_a8) { described_class.new('a', 8) }

      it 'returns an array of southern adjacencies in order from the source' do
        result = algebraic_coords_a8.to_southern_adjacencies
        strings = result.map(&:to_s)
        expect(strings).to eq(%w[a7 a6 a5 a4 a3 a2 a1])
      end
    end

    context 'when testing with coordinates a1' do
      subject(:algebraic_coords_a1) { described_class.new('a', 1) }

      it 'returns an empty array' do
        result = algebraic_coords_a1.to_southern_adjacencies
        expect(result).to be_an(Array).and be_empty
      end
    end
  end

  describe '#to_western_adjacencies' do
    context 'when testing with coordinates h8' do
      subject(:algebraic_coords_h8) { described_class.new('h', 8) }

      it 'returns an array of the western adjacencies in order from the source' do
        result = algebraic_coords_h8.to_western_adjacencies
        strings = result.map(&:to_s)
        expect(strings).to eq(%w[g8 f8 e8 d8 c8 b8 a8])
      end
    end

    context 'when testing with coordinates a8' do
      subject(:algebraic_coords_a8) { described_class.new('a', 8) }

      it 'returns an empty array' do
        result = algebraic_coords_a8.to_western_adjacencies
        expect(result).to be_an(Array).and be_empty
      end
    end
  end

  describe '#to_north_eastern_adjacencies' do
    context 'when testing with coordinates e4' do
      subject(:algebraic_coords_e4) { described_class.new('e', 4) }

      it 'returns an array of the north eastern adjacencies in order from the source' do
        result = algebraic_coords_e4.to_north_eastern_adjacencies
        strings = result.map(&:to_s)
        expect(strings).to eq(%w[f5 g6 h7])
      end
    end

    context 'when testing with coordinates h7' do
      subject(:algebraic_coords_h7) { described_class.new('h', 7) }

      it 'returns an empty array' do
        result = algebraic_coords_h7.to_north_eastern_adjacencies
        expect(result).to be_an(Array).and be_empty
      end
    end
  end

  describe '#to_south_eastern_adjacencies' do
    context 'when testing with coordinates e4' do
      subject(:algebraic_coords_e4) { described_class.new('e', 4) }

      it 'returns an array of the south eastern adjacencies in order from the source' do
        result = algebraic_coords_e4.to_south_eastern_adjacencies
        strings = result.map(&:to_s)
        expect(strings).to eq(%w[f3 g2 h1])
      end
    end

    context 'when testing with coordinates h1' do
      subject(:algebraic_coords_h1) { described_class.new('h', 1) }

      it 'returns an empty array' do
        result = algebraic_coords_h1.to_south_eastern_adjacencies
        expect(result).to be_an(Array).and be_empty
      end
    end
  end

  describe '#to_south_western_adjacencies' do
    context 'when testing with coordinates e4' do
      subject(:algebraic_coords_e4) { described_class.new('e', 4) }

      it 'returns an array of the south western adjacencies in order from the source' do
        result = algebraic_coords_e4.to_south_western_adjacencies
        strings = result.map(&:to_s)
        expect(strings).to eq(%w[d3 c2 b1])
      end
    end

    context 'when testing with coordinates b1' do
      subject(:algebraic_coords_b1) { described_class.new('b', 1) }

      it 'returns an empty array' do
        result = algebraic_coords_b1.to_south_western_adjacencies
        expect(result).to be_an(Array).and be_empty
      end
    end
  end

  describe '#to_north_western_adjacencies' do
    context 'when testing with coordinates e4' do
      subject(:algebraic_coords_e4) { described_class.new('e', 4) }

      it 'returns an array of the north western adjacencies in order from the source' do
        result = algebraic_coords_e4.to_north_western_adjacencies
        strings = result.map(&:to_s)
        expect(strings).to eq(%w[d5 c6 b7 a8])
      end
    end

    context 'when testing with coordinates a8' do
      subject(:algebraic_coords_a8) { described_class.new('a', 8) }

      it 'returns an empty array' do
        result = algebraic_coords_a8.to_north_western_adjacencies
        expect(result).to be_an(Array).and be_empty
      end
    end
  end

  describe '#adjustment_in_bounds?' do
    subject(:algebraic_coords_a8) { described_class.new('a', 8) }

    context 'when both coordinates would remain in bounds post adjustment' do
      it 'returns true' do
        file_adjustment = 1
        rank_adjustment = -1
        result = algebraic_coords_a8.adjustment_in_bounds?(file_adjustment, rank_adjustment)
        expect(result).to be(true)
      end
    end

    context 'when the file coordinate would fall out of lower bounds post adjustment' do
      it 'returns false' do
        file_adjustment = -1
        rank_adjustment = 0
        result = algebraic_coords_a8.adjustment_in_bounds?(file_adjustment, rank_adjustment)
        expect(result).to be(false)
      end
    end

    context 'when the file coordinate would fall out of upper bounds post adjustment' do
      it 'returns false' do
        file_adjustment = 8
        rank_adjustment = 0
        result = algebraic_coords_a8.adjustment_in_bounds?(file_adjustment, rank_adjustment)
        expect(result).to be(false)
      end
    end

    context 'when the rank coordinate would fall out of lower bounds post adjustment' do
      it 'returns false' do
        file_adjustment = 0
        rank_adjustment = -8
        result = algebraic_coords_a8.adjustment_in_bounds?(file_adjustment, rank_adjustment)
        expect(result).to be(false)
      end
    end

    context 'when the rank coordinate would fall out of upper bounds post adjustment' do
      it 'returns false' do
        file_adjustment = 0
        rank_adjustment = 1
        result = algebraic_coords_a8.adjustment_in_bounds?(file_adjustment, rank_adjustment)
        expect(result).to be(false)
      end
    end

    context 'when both coordinates would fall out of bounds post adjustment' do
      it 'returns false' do
        file_adjustment = -1
        rank_adjustment = 1
        result = algebraic_coords_a8.adjustment_in_bounds?(file_adjustment, rank_adjustment)
        expect(result).to be(false)
      end
    end
  end

  describe '#file_to_i' do
    subject(:algebraic_coords_a8) { described_class.new('a', 8) }

    it 'returns the file coordinate\'s integer equivalent' do
      result = algebraic_coords_a8.file_to_i
      expect(result).to eq(1)
    end
  end

  describe '#to_s' do
    subject(:algebraic_coords_a8) { described_class.new('a', 8) }

    it 'returns the coordinates as a string' do
      result = algebraic_coords_a8.to_s
      expect(result).to eq('a8')
    end
  end
end
