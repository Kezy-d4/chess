# frozen_string_literal: true

describe Chess::AlgebraicCoords do
  describe '::from_s' do
    context 'when passed coordinates a8 as a string' do
      subject { described_class }

      let(:string) { 'a8' }

      it 'returns an AlgebraicCoords with the expected file coordinate' do
        result = described_class.from_s(string)
        file = result.instance_variable_get(:@file)
        expect(file).to eq('a')
      end

      it 'returns an AlgebraicCoords with the expected rank coordinate' do
        result = described_class.from_s(string)
        rank = result.instance_variable_get(:@rank)
        expect(rank).to eq(8)
      end
    end
  end

  describe '#to_adjacency' do
    subject(:algebraic_coords_a8) { described_class.new('a', 8) }

    context 'when the adjacency would remain in bounds' do
      let(:file_adjustment) { 1 }
      let(:rank_adjustment) { -1 }

      # rubocop: disable RSpec/MultipleExpectations
      it 'returns a new AlgebraicCoords with the adjusted file coordinate' do
        result = algebraic_coords_a8.to_adjacency(file_adjustment, rank_adjustment)
        file = result.instance_variable_get(:@file)
        expect(result).not_to be(algebraic_coords_a8)
        expect(file).to eq('b')
      end

      it 'returns a new AlgebraicCoords with the adjusted rank coordinate' do
        result = algebraic_coords_a8.to_adjacency(file_adjustment, rank_adjustment)
        rank = result.instance_variable_get(:@rank)
        expect(result).not_to be(algebraic_coords_a8)
        expect(rank).to eq(7)
      end
      # rubocop: enable all
    end

    context 'when the adjacency would fall out of bounds' do
      it 'returns nil' do
        result = algebraic_coords_a8.to_adjacency(-1, 1)
        expect(result).to be_nil
      end
    end
  end

  describe '#to_adjacency_string' do
    subject(:algebraic_coords_a8) { described_class.new('a', 8) }

    context 'when the adjacency would remain in bounds' do
      it 'returns the adjusted coordinates as a string' do
        result = algebraic_coords_a8.to_adjacency_string(1, -1)
        expect(result).to eq('b7')
      end
    end

    context 'when the adjacency would fall out of bounds' do
      it 'returns nil' do
        result = algebraic_coords_a8.to_adjacency_string(-1, 1)
        expect(result).to be_nil
      end
    end
  end

  describe '#to_northern_adjacencies' do
    context 'when testing with AlgebraicCoords a1' do
      subject(:algebraic_coords_a1) { described_class.new('a', 1) }

      it 'returns an array of the northern string adjacencies' do
        result = algebraic_coords_a1.to_northern_adjacencies
        expect(result).to eq(%w[a2 a3 a4 a5 a6 a7 a8])
      end
    end

    context 'when testing with AlgebraicCoords a8' do
      subject(:algebraic_coords_a8) { described_class.new('a', 8) }

      it 'returns an empty array' do
        result = algebraic_coords_a8.to_northern_adjacencies
        expect(result).to be_an(Array).and be_empty
      end
    end
  end

  describe '#to_eastern_adjacencies' do
    context 'when testing with AlgebraicCoords a8' do
      subject(:algebraic_coords_a8) { described_class.new('a', 8) }

      it 'returns an array of the eastern string adjacencies' do
        result = algebraic_coords_a8.to_eastern_adjacencies
        expect(result).to eq(%w[b8 c8 d8 e8 f8 g8 h8])
      end
    end

    context 'when testing with AlgebraicCoords h8' do
      subject(:algebraic_coords_h8) { described_class.new('h', 8) }

      it 'returns an empty array' do
        result = algebraic_coords_h8.to_eastern_adjacencies
        expect(result).to be_an(Array).and be_empty
      end
    end
  end

  describe '#to_southern_adjacencies' do
    context 'when testing with AlgebraicCoords a8' do
      subject(:algebraic_coords_a8) { described_class.new('a', 8) }

      it 'returns an array of the southern string adjacencies' do
        result = algebraic_coords_a8.to_southern_adjacencies
        expect(result).to eq(%w[a7 a6 a5 a4 a3 a2 a1])
      end
    end

    context 'when testing with AlgebraicCoords a1' do
      subject(:algebraic_coords_a1) { described_class.new('a', 1) }

      it 'returns an empty array' do
        result = algebraic_coords_a1.to_southern_adjacencies
        expect(result).to be_an(Array).and be_empty
      end
    end
  end

  describe '#to_western_adjacencies' do
    context 'when testing with AlgebraicCoords h8' do
      subject(:algebraic_coords_h8) { described_class.new('h', 8) }

      it 'returns an array of the western string adjacencies' do
        result = algebraic_coords_h8.to_western_adjacencies
        expect(result).to eq(%w[g8 f8 e8 d8 c8 b8 a8])
      end
    end

    context 'when testing with AlgebraicCoords a8' do
      subject(:algebraic_coords_a8) { described_class.new('a', 8) }

      it 'returns an empty array' do
        result = algebraic_coords_a8.to_western_adjacencies
        expect(result).to be_an(Array).and be_empty
      end
    end
  end

  describe '#to_north_eastern_adjacencies' do
    context 'when testing with AlgebraicCoords a1' do
      subject(:algebraic_coords_a1) { described_class.new('a', 1) }

      it 'returns an array of the north eastern string adjacencies' do
        result = algebraic_coords_a1.to_north_eastern_adjacencies
        expect(result).to eq(%w[b2 c3 d4 e5 f6 g7 h8])
      end
    end

    context 'when testing with AlgebraicCoords h8' do
      subject(:algebraic_coords_h8) { described_class.new('h', 8) }

      it 'returns an empty array' do
        result = algebraic_coords_h8.to_north_eastern_adjacencies
        expect(result).to be_an(Array).and be_empty
      end
    end
  end

  describe '#to_south_eastern_adjacencies' do
    context 'when testing with AlgebraicCoords a8' do
      subject(:algebraic_coords_a8) { described_class.new('a', 8) }

      it 'returns an array of the south eastern string adjacencies' do
        result = algebraic_coords_a8.to_south_eastern_adjacencies
        expect(result).to eq(%w[b7 c6 d5 e4 f3 g2 h1])
      end
    end

    context 'when testing with AlgebraicCoords h1' do
      subject(:algebraic_coords_h1) { described_class.new('h', 1) }

      it 'returns an empty array' do
        result = algebraic_coords_h1.to_south_eastern_adjacencies
        expect(result).to be_an(Array).and be_empty
      end
    end
  end

  describe '#to_south_western_adjacencies' do
    context 'when testing with AlgebraicCoords h8' do
      subject(:algebraic_coords_h8) { described_class.new('h', 8) }

      it 'returns an array of the south western string adjacencies' do
        result = algebraic_coords_h8.to_south_western_adjacencies
        expect(result).to eq(%w[g7 f6 e5 d4 c3 b2 a1])
      end
    end

    context 'when testing with AlgebraicCoords a1' do
      subject(:algebraic_coords_a1) { described_class.new('a', 1) }

      it 'returns an empty array' do
        result = algebraic_coords_a1.to_south_western_adjacencies
        expect(result).to be_an(Array).and be_empty
      end
    end
  end

  describe 'to_north_western_adjacencies' do
    context 'when testing with AlgebraicCoords h1' do
      subject(:algebraic_coords_h1) { described_class.new('h', 1) }

      it 'returns an array of the north western string adjacencies' do
        result = algebraic_coords_h1.to_north_western_adjacencies
        expect(result).to eq(%w[g2 f3 e4 d5 c6 b7 a8])
      end
    end

    context 'when testing with AlgebraicCoords a8' do
      subject(:algebraic_coords_a8) { described_class.new('a', 8) }

      it 'returns an empty array' do
        result = algebraic_coords_a8.to_north_western_adjacencies
        expect(result).to be_an(Array).and be_empty
      end
    end
  end

  describe '#adjustment_in_bounds?' do
    subject(:algebraic_coords_b7) { described_class.new('b', 7) }

    context 'when the file and rank adjustments would both remain in bounds' do
      it 'returns true' do
        result = algebraic_coords_b7.adjustment_in_bounds?(-1, 1)
        expect(result).to be(true)
      end
    end

    context 'when the file adjustment would fall out of lower bounds' do
      it 'returns false' do
        result = algebraic_coords_b7.adjustment_in_bounds?(-2, 0)
        expect(result).to be(false)
      end
    end

    context 'when the file adjustment would fall out of upper bounds' do
      it 'returns false' do
        result = algebraic_coords_b7.adjustment_in_bounds?(7, 0)
        expect(result).to be(false)
      end
    end

    context 'when the rank adjustment would fall out of lower bounds' do
      it 'returns false' do
        result = algebraic_coords_b7.adjustment_in_bounds?(0, -7)
        expect(result).to be(false)
      end
    end

    context 'when the rank adjustment would fall out of upper bounds' do
      it 'returns false' do
        result = algebraic_coords_b7.adjustment_in_bounds?(0, 2)
        expect(result).to be(false)
      end
    end

    context 'when the file and rank adjustments would both fall out of bounds' do
      it 'returns false' do
        result = algebraic_coords_b7.adjustment_in_bounds?(-2, 2)
        expect(result).to be(false)
      end
    end
  end

  describe '#file_to_i' do
    context 'when testing with AlgebraicCoords a8' do
      subject(:algebraic_coords_a8) { described_class.new('a', 8) }

      it 'returns the file\'s integer equivalent' do
        result = algebraic_coords_a8.file_to_i
        expect(result).to eq(1)
      end
    end

    context 'when testing with AlgebraicCoords h8' do
      subject(:algebraic_coords_h8) { described_class.new('h', 8) }

      it 'returns the file\'s integer equivalent' do
        result = algebraic_coords_h8.file_to_i
        expect(result).to eq(8)
      end
    end

    context 'when testing with AlgebraicCoords e8' do
      subject(:algebraic_coords_e8) { described_class.new('e', 8) }

      it 'returns the file\'s integer equivalent' do
        result = algebraic_coords_e8.file_to_i
        expect(result).to eq(5)
      end
    end
  end

  describe '#to_s' do
    context 'when testing with AlgebraicCoords a8' do
      subject(:algebraic_coords_a8) { described_class.new('a', 8) }

      it 'returns the coordinates as a string' do
        result = algebraic_coords_a8.to_s
        expect(result).to eq('a8')
      end
    end
  end
end
