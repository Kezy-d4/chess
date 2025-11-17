# frozen_string_literal: true

require_relative '../lib/adjacent_coords_generator'

describe AdjacentCoordsGenerator do
  describe '#generate_northern_coords' do
    context 'when testing with coordinates e4' do
      subject(:adjacent_coords_generator_e4) { described_class.new('e4') }

      it 'returns an array of the in bounds northern coordinates in stepwise order' do
        result = adjacent_coords_generator_e4.generate_northern_coords
        expect(result).to eq(%w[e5 e6 e7 e8])
      end
    end

    context 'when testing with coordinates e8' do
      subject(:adjacent_coords_generator_e8) { described_class.new('e8') }

      it 'returns an empty array' do
        result = adjacent_coords_generator_e8.generate_northern_coords
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_north_eastern_coords' do
    context 'when testing with coordinates e4' do
      subject(:adjacent_coords_generator_e4) { described_class.new('e4') }

      it 'returns an array of the in bounds north eastern coordinates in stepwise order' do
        result = adjacent_coords_generator_e4.generate_north_eastern_coords
        expect(result).to eq(%w[f5 g6 h7])
      end
    end

    context 'when testing with coordinates h4' do
      subject(:adjacent_coords_generator_h4) { described_class.new('h4') }

      it 'returns an empty array' do
        result = adjacent_coords_generator_h4.generate_north_eastern_coords
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_eastern_coords' do
    context 'when testing with coordinates e4' do
      subject(:adjacent_coords_generator_e4) { described_class.new('e4') }

      it 'returns an array of the in bounds eastern coordinates in stepwise order' do
        result = adjacent_coords_generator_e4.generate_eastern_coords
        expect(result).to eq(%w[f4 g4 h4])
      end
    end

    context 'when testing with coordinates h4' do
      subject(:adjacent_coords_generator_h4) { described_class.new('h4') }

      it 'returns an empty array' do
        result = adjacent_coords_generator_h4.generate_eastern_coords
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_south_eastern_coords' do
    context 'when testing with coordinates e4' do
      subject(:adjacent_coords_generator_e4) { described_class.new('e4') }

      it 'returns an array of the in bounds south eastern coordinates in stepwise order' do
        result = adjacent_coords_generator_e4.generate_south_eastern_coords
        expect(result).to eq(%w[f3 g2 h1])
      end
    end

    context 'when testing with coordinates h4' do
      subject(:adjacent_coords_generator_h4) { described_class.new('h4') }

      it 'returns an empty array' do
        result = adjacent_coords_generator_h4.generate_south_eastern_coords
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_southern_coords' do
    context 'when testing with coordinates e4' do
      subject(:adjacent_coords_generator_e4) { described_class.new('e4') }

      it 'returns an array of the in bounds southern coordinates in stepwise order' do
        result = adjacent_coords_generator_e4.generate_southern_coords
        expect(result).to eq(%w[e3 e2 e1])
      end
    end

    context 'when testing with coordinates e1' do
      subject(:adjacent_coords_generator_e1) { described_class.new('e1') }

      it 'returns an empty array' do
        result = adjacent_coords_generator_e1.generate_southern_coords
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_south_western_coords' do
    context 'when testing with coordinates e4' do
      subject(:adjacent_coords_generator_e4) { described_class.new('e4') }

      it 'returns an array of the in bounds south western coordinates in stepwise order' do
        result = adjacent_coords_generator_e4.generate_south_western_coords
        expect(result).to eq(%w[d3 c2 b1])
      end
    end

    context 'when testing with coordinates a4' do
      subject(:adjacent_coords_generator_a4) { described_class.new('a4') }

      it 'returns an empty array' do
        result = adjacent_coords_generator_a4.generate_south_western_coords
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_western_coords' do
    context 'when testing with coordinates e4' do
      subject(:adjacent_coords_generator_e4) { described_class.new('e4') }

      it 'returns an array of the in bounds western coordinates in stepwise order' do
        result = adjacent_coords_generator_e4.generate_western_coords
        expect(result).to eq(%w[d4 c4 b4 a4])
      end
    end

    context 'when testing with coordinates a4' do
      subject(:adjacent_coords_generator_a4) { described_class.new('a4') }

      it 'returns an empty array' do
        result = adjacent_coords_generator_a4.generate_western_coords
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_north_western_coords' do
    context 'when testing with coordinates e4' do
      subject(:adjacent_coords_generator_e4) { described_class.new('e4') }

      it 'returns an array of the in bounds north western coordinates in stepwise order' do
        result = adjacent_coords_generator_e4.generate_north_western_coords
        expect(result).to eq(%w[d5 c6 b7 a8])
      end
    end

    context 'when testing with coordinates a4' do
      subject(:adjacent_coords_generator_a4) { described_class.new('a4') }

      it 'returns an empty array' do
        result = adjacent_coords_generator_a4.generate_north_western_coords
        expect(result).to be_empty
      end
    end
  end

  describe '#generate_knight_adjacent_coords' do
    context 'when testing with coordinates e4' do
      subject(:adjacent_coords_generator_e4) { described_class.new('e4') }

      let(:expected) do
        { north_east_one: 'f6',
          north_east_two: 'g5',
          south_east_one: 'f2',
          south_east_two: 'g3',
          south_west_one: 'c3',
          south_west_two: 'd2',
          north_west_one: 'c5',
          north_west_two: 'd6' }
      end

      it 'returns a hash of the in bounds knight adjacent coordinates in each direction' do
        result = adjacent_coords_generator_e4.generate_knight_adjacent_coords
        expect(result).to eq(expected)
      end
    end

    context 'when testing with coordinates b6' do
      subject(:adjacent_coords_generator_b6) { described_class.new('b6') }

      let(:expected) do
        { north_east_one: 'c8',
          north_east_two: 'd7',
          south_east_one: 'c4',
          south_east_two: 'd5',
          south_west_two: 'a4',
          north_west_two: 'a8' }
      end

      it 'returns a hash of the in bounds knight adjacent coordinates in each direction' do
        result = adjacent_coords_generator_b6.generate_knight_adjacent_coords
        expect(result).to eq(expected)
      end
    end
  end
end
