# frozen_string_literal: true

require_relative '../../lib/pieces/pawn'

describe Pawn do
  describe '#generate_adjacent_movement_coords' do
    context 'when the Pawn is white, has not moved, and is passed AlgebraicCoords e2' do
      subject(:pawn_white_unmoved) { described_class.new(:white) }

      let(:algebraic_coords_e2) do
        double(
          'AlgebraicCoords',
          to_northern_adjacencies: %w[e3 e4 e5 e6 e7 e8]
        )
      end

      let(:expected) { { north: %w[e3 e4] } }

      it 'returns a hash of adjacent coordinates per direction' do
        result = pawn_white_unmoved.generate_adjacent_movement_coords(algebraic_coords_e2)
        expect(result).to eq(expected)
      end
    end

    context 'when the Pawn is white, has moved, and is passed AlgebraicCoords e4' do
      subject(:pawn_white_moved) { described_class.new(:white, 1) }

      let(:algebraic_coords_e4) do
        double(
          'AlgebraicCoords',
          to_northern_adjacencies: %w[e5 e6 e7 e8]
        )
      end

      let(:expected) { { north: %w[e5] } }

      it 'returns a hash of adjacent coordinates per direction' do
        result = pawn_white_moved.generate_adjacent_movement_coords(algebraic_coords_e4)
        expect(result).to eq(expected)
      end
    end

    context 'when the Pawn is white, has moved, and is passed AlgebraicCoords e8' do
      subject(:pawn_white_edge) { described_class.new(:white, 5) }

      let(:algebraic_coords_e8) do
        double(
          'AlgebraicCoords',
          to_northern_adjacencies: %w[]
        )
      end

      it 'returns an empty hash' do
        result = pawn_white_edge.generate_adjacent_movement_coords(algebraic_coords_e8)
        expect(result).to be_a(Hash).and be_empty
      end
    end

    context 'when the Pawn is black, has not moved, and is passed AlgebraicCoords e7' do
      subject(:pawn_black_unmoved) { described_class.new(:black) }

      let(:algebraic_coords_e7) do
        double(
          'AlgebraicCoords',
          to_southern_adjacencies: %w[e6 e5 e4 e3 e2 e1]
        )
      end

      let(:expected) { { south: %w[e6 e5] } }

      it 'returns a hash of adjacent coordinates per direction' do
        result = pawn_black_unmoved.generate_adjacent_movement_coords(algebraic_coords_e7)
        expect(result).to eq(expected)
      end
    end

    context 'when the Pawn is black, has moved, and is passed AlgebraicCoords e5' do
      subject(:pawn_black_moved) { described_class.new(:black, 1) }

      let(:algebraic_coords_e5) do
        double(
          'AlgebraicCoords',
          to_southern_adjacencies: %w[e4 e3 e2 e1]
        )
      end

      let(:expected) { { south: %w[e4] } }

      it 'returns a hash of adjacent coordinates per direction' do
        result = pawn_black_moved.generate_adjacent_movement_coords(algebraic_coords_e5)
        expect(result).to eq(expected)
      end
    end

    context 'when the Pawn is black, has moved, and is passed AlgebraicCoords e1' do
      subject(:pawn_black_edge) { described_class.new(:black, 5) }

      let(:algebraic_coords_e1) do
        double(
          'AlgebraicCoords',
          to_southern_adjacencies: %w[]
        )
      end

      it 'returns an empty hash' do
        result = pawn_black_edge.generate_adjacent_movement_coords(algebraic_coords_e1)
        expect(result).to be_a(Hash).and be_empty
      end
    end
  end

  describe '#generate_adjacent_capture_coords' do
    context 'when the Pawn is white and is passed AlgebraicCoords e4' do
      subject(:pawn_white_full_cap) { described_class.new(:white, 1) }

      let(:algebraic_coords_e4) do
        double(
          'AlgebraicCoords',
          to_north_western_adjacencies: %w[d5 c6 b7 a8],
          to_north_eastern_adjacencies: %w[f5 g6 h7]
        )
      end

      let(:expected) do
        { north_west: %w[d5],
          north_east: %w[f5] }
      end

      it 'returns a hash of adjacent coordinates per direction' do
        result = pawn_white_full_cap.generate_adjacent_capture_coords(algebraic_coords_e4)
        expect(result).to eq(expected)
      end
    end

    context 'when the Pawn is white and is passed AlgebraicCoords a4' do
      subject(:pawn_white_right_cap) { described_class.new(:white, 1) }

      let(:algebraic_coords_a4) do
        double(
          'AlgebraicCoords',
          to_north_western_adjacencies: %w[],
          to_north_eastern_adjacencies: %w[b5 c6 d7 e8]
        )
      end

      let(:expected) { { north_east: %w[b5] } }

      it 'returns a hash of adjacent coordinates per direction' do
        result = pawn_white_right_cap.generate_adjacent_capture_coords(algebraic_coords_a4)
        expect(result).to eq(expected)
      end
    end

    context 'when the Pawn is white and is passed AlgebraicCoords h4' do
      subject(:pawn_white_left_cap) { described_class.new(:white, 1) }

      let(:algebraic_coords_h4) do
        double(
          'AlgebraicCoords',
          to_north_western_adjacencies: %w[g5 f6 e7 d8],
          to_north_eastern_adjacencies: %w[]
        )
      end

      let(:expected) { { north_west: %w[g5] } }

      it 'returns a hash of adjacent coordinates per direction' do
        result = pawn_white_left_cap.generate_adjacent_capture_coords(algebraic_coords_h4)
        expect(result).to eq(expected)
      end
    end

    context 'when the Pawn is white and is passed AlgebraicCoords e8' do
      subject(:pawn_white_edge) { described_class.new(:white, 5) }

      let(:algebraic_coords_e8) do
        double(
          'AlgebraicCoords',
          to_north_western_adjacencies: %w[],
          to_north_eastern_adjacencies: %w[]
        )
      end

      it 'returns an empty hash' do
        result = pawn_white_edge.generate_adjacent_capture_coords(algebraic_coords_e8)
        expect(result).to be_a(Hash).and be_empty
      end
    end

    context 'when the Pawn is black and is passed AlgebraicCoords e5' do
      subject(:pawn_black_full_cap) { described_class.new(:black, 1) }

      let(:algebraic_coords_e5) do
        double(
          'AlgebraicCoords',
          to_south_western_adjacencies: %w[d4 c3 b2 a1],
          to_south_eastern_adjacencies: %w[f4 g3 h2]
        )
      end

      let(:expected) do
        { south_west: %w[d4],
          south_east: %w[f4] }
      end

      it 'returns a hash of adjacent coordinates per direction' do
        result = pawn_black_full_cap.generate_adjacent_capture_coords(algebraic_coords_e5)
        expect(result).to eq(expected)
      end
    end

    context 'when the Pawn is black and is passed AlgebraicCoords a5' do
      subject(:pawn_black_right_cap) { described_class.new(:black, 1) }

      let(:algebraic_coords_a5) do
        double(
          'AlgebraicCoords',
          to_south_western_adjacencies: %w[],
          to_south_eastern_adjacencies: %w[b4 c3 d2 e1]
        )
      end

      let(:expected) { { south_east: %w[b4] } }

      it 'returns a hash of adjacent coordinates per direction' do
        result = pawn_black_right_cap.generate_adjacent_capture_coords(algebraic_coords_a5)
        expect(result).to eq(expected)
      end
    end

    context 'when the Pawn is black and is passed AlgebraicCoords h5' do
      subject(:pawn_black_left_cap) { described_class.new(:black, 1) }

      let(:algebraic_coords_h5) do
        double(
          'AlgebraicCoords',
          to_south_western_adjacencies: %w[g4 f3 e2 d1],
          to_south_eastern_adjacencies: %w[]
        )
      end

      let(:expected) { { south_west: %w[g4] } }

      it 'returns a hash of adjacent coordinates per direction' do
        result = pawn_black_left_cap.generate_adjacent_capture_coords(algebraic_coords_h5)
        expect(result).to eq(expected)
      end
    end

    context 'when the Pawn is black and is passed AlgebraicCoords e1' do
      subject(:pawn_black_edge) { described_class.new(:black, 5) }

      let(:algebraic_coords_e1) do
        double(
          'AlgebraicCoords',
          to_south_western_adjacencies: %w[],
          to_south_eastern_adjacencies: %w[]
        )
      end

      it 'returns an empty hash' do
        result = pawn_black_edge.generate_adjacent_capture_coords(algebraic_coords_e1)
        expect(result).to be_a(Hash).and be_empty
      end
    end
  end
end
