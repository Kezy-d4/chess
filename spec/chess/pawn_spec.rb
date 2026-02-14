# frozen_string_literal: true

describe Chess::Pawn do
  describe '#to_adjacent_movement_coords' do
    context 'when white, unmoved and passed Coord e2' do
      subject(:pawn_white_unmoved) { described_class.new(:white) }

      let(:coord_e2) { Chess::Coord.new('e', 2) }
      let(:expected) do
        { north: %w[e3 e4] }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end

      it 'returns a hash of adjacencies per direction' do
        result = pawn_white_unmoved.to_adjacent_movement_coords(coord_e2)
        expect(result).to eq(expected)
      end
    end

    context 'when white, moved and passed Coord e4' do
      subject(:pawn_white_moved) { described_class.new(:white, 1) }

      let(:coord_e4) { Chess::Coord.new('e', 4) }
      let(:expected) do
        { north: %w[e5] }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end

      it 'returns a hash of adjacencies per direction' do
        result = pawn_white_moved.to_adjacent_movement_coords(coord_e4)
        expect(result).to eq(expected)
      end
    end

    context 'when white, moved and passed Coord e8' do
      subject(:pawn_white_edge) { described_class.new(:white, 5) }

      let(:coord_e8) { Chess::Coord.new('e', 8) }

      it 'returns an empty hash' do
        result = pawn_white_edge.to_adjacent_movement_coords(coord_e8)
        expect(result).to be_a(Hash).and be_empty
      end
    end

    context 'when black, unmoved and passed Coord e7' do
      subject(:pawn_black_unmoved) { described_class.new(:black) }

      let(:coord_e7) { Chess::Coord.new('e', 7) }
      let(:expected) do
        { south: %w[e6 e5] }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end

      it 'returns a hash of adjacencies per direction' do
        result = pawn_black_unmoved.to_adjacent_movement_coords(coord_e7)
        expect(result).to eq(expected)
      end
    end

    context 'when black, moved and passed Coord e5' do
      subject(:pawn_black_moved) { described_class.new(:black, 1) }

      let(:coord_e5) { Chess::Coord.new('e', 5) }
      let(:expected) do
        { south: %w[e4] }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end

      it 'returns a hash of adjacencies per direction' do
        result = pawn_black_moved.to_adjacent_movement_coords(coord_e5)
        expect(result).to eq(expected)
      end
    end

    context 'when black, moved and passed Coord e1' do
      subject(:pawn_black_edge) { described_class.new(:black, 5) }

      let(:coord_e1) { Chess::Coord.new('e', 1) }

      it 'returns an empty hash' do
        result = pawn_black_edge.to_adjacent_movement_coords(coord_e1)
        expect(result).to be_a(Hash).and be_empty
      end
    end
  end

  describe '#to_adjacent_capture_coords' do
    context 'when white and passed Coord e4' do
      subject(:pawn_white_full_cap) { described_class.new(:white, 1) }

      let(:coord_e4) { Chess::Coord.new('e', 4) }
      let(:expected) do
        {
          north_west: %w[d5],
          north_east: %w[f5]
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end

      it 'returns a hash of adjacencies per direction' do
        result = pawn_white_full_cap.to_adjacent_capture_coords(coord_e4)
        expect(result).to eq(expected)
      end
    end

    context 'when white and passed Coord a4' do
      subject(:pawn_white_right_cap) { described_class.new(:white, 1) }

      let(:coord_a4) { Chess::Coord.new('a', 4) }
      let(:expected) do
        { north_east: %w[b5] }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end

      it 'returns a hash of adjacencies per direction' do
        result = pawn_white_right_cap.to_adjacent_capture_coords(coord_a4)
        expect(result).to eq(expected)
      end
    end

    context 'when white and passed Coord h4' do
      subject(:pawn_white_left_cap) { described_class.new(:white, 1) }

      let(:coord_h4) { Chess::Coord.new('h', 4) }
      let(:expected) do
        { north_west: %w[g5] }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end

      it 'returns a hash of adjacencies per direction' do
        result = pawn_white_left_cap.to_adjacent_capture_coords(coord_h4)
        expect(result).to eq(expected)
      end
    end

    context 'when white and passed Coord e8' do
      subject(:pawn_white_edge) { described_class.new(:white, 5) }

      let(:coord_e8) { Chess::Coord.new('e', 8) }

      it 'returns an empty hash' do
        result = pawn_white_edge.to_adjacent_capture_coords(coord_e8)
        expect(result).to be_a(Hash).and be_empty
      end
    end

    context 'when black and passed Coord e5' do
      subject(:pawn_black_full_cap) { described_class.new(:black, 1) }

      let(:coord_e5) { Chess::Coord.new('e', 5) }
      let(:expected) do
        {
          south_west: %w[d4],
          south_east: %w[f4]
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end

      it 'returns a hash of adjacencies per direction' do
        result = pawn_black_full_cap.to_adjacent_capture_coords(coord_e5)
        expect(result).to eq(expected)
      end
    end

    context 'when black and passed Coord a5' do
      subject(:pawn_black_left_cap) { described_class.new(:black, 1) }

      let(:coord_a5) { Chess::Coord.new('a', 5) }
      let(:expected) do
        { south_east: %w[b4] }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end

      it 'returns a hash of adjacencies per direction' do
        result = pawn_black_left_cap.to_adjacent_capture_coords(coord_a5)
        expect(result).to eq(expected)
      end
    end

    context 'when black and passed Coord h5' do
      subject(:pawn_black_right_cap) { described_class.new(:black, 1) }

      let(:coord_h5) { Chess::Coord.new('h', 5) }
      let(:expected) do
        { south_west: %w[g4] }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end

      it 'returns a hash of adjacencies per direction' do
        result = pawn_black_right_cap.to_adjacent_capture_coords(coord_h5)
        expect(result).to eq(expected)
      end
    end

    context 'when black and passed Coord e1' do
      subject(:pawn_black_edge) { described_class.new(:black, 5) }

      let(:coord_e1) { Chess::Coord.new('e', 1) }

      it 'returns an empty hash' do
        result = pawn_black_edge.to_adjacent_capture_coords(coord_e1)
        expect(result).to be_a(Hash).and be_empty
      end
    end
  end
end
