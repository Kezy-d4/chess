# frozen_string_literal: true

require_relative '../../lib/pieces/rook'

describe Rook do
  describe '#generate_adjacent_movement_coords' do
    subject(:rook) { described_class.new(:white) }

    context 'when passed AlgebraicCoords e4' do
      let(:algebraic_coords_e4) do
        double(
          'AlgebraicCoords',
          to_northern_adjacencies: %w[e5 e6 e7 e8],
          to_eastern_adjacencies: %w[f4 g4 h4],
          to_southern_adjacencies: %w[e3 e2 e1],
          to_western_adjacencies: %w[d4 c4 b4 a4],
          to_north_eastern_adjacencies: %w[f5 g6 h7],
          to_south_eastern_adjacencies: %w[f3 g2 h1],
          to_south_western_adjacencies: %w[d3 c2 b1],
          to_north_western_adjacencies: %w[d5 c6 b7 a8]
        )
      end

      let(:expected) do
        { north: %w[e5 e6 e7 e8],
          east: %w[f4 g4 h4],
          south: %w[e3 e2 e1],
          west: %w[d4 c4 b4 a4] }
      end

      it 'returns a hash of adjacent coordinates per direction' do
        result = rook.generate_adjacent_movement_coords(algebraic_coords_e4)
        expect(result).to eq(expected)
      end
    end

    context 'when passed AlgebraicCoords a8' do
      let(:algebraic_coords_a8) do
        double(
          'AlgebraicCoords',
          to_northern_adjacencies: %w[],
          to_eastern_adjacencies: %w[b8 c8 d8 e8 f8 g8 h8],
          to_southern_adjacencies: %w[a7 a6 a5 a4 a3 a2 a1],
          to_western_adjacencies: %w[],
          to_north_eastern_adjacencies: %w[],
          to_south_eastern_adjacencies: %w[b7 c6 d5 e4 f3 g2 h1],
          to_south_western_adjacencies: %w[],
          to_north_western_adjacencies: %w[]
        )
      end

      let(:expected) do
        { east: %w[b8 c8 d8 e8 f8 g8 h8],
          south: %w[a7 a6 a5 a4 a3 a2 a1] }
      end

      it 'returns a hash of adjacent coordinates per direction' do
        result = rook.generate_adjacent_movement_coords(algebraic_coords_a8)
        expect(result).to eq(expected)
      end
    end
  end

  describe '#generate_adjacent_capture_coords' do
    subject(:rook) { described_class.new(:white) }

    let(:algebraic_coords) { double('AlgebraicCoords') }

    # rubocop: disable RSpec/SubjectStub
    it 'sends the #generate_adjacent_movement_coords message to self with the passed AlgebraicCoords' do
      allow(rook).to receive(:generate_adjacent_movement_coords).with(algebraic_coords)
      rook.generate_adjacent_capture_coords(algebraic_coords)
      expect(rook).to have_received(:generate_adjacent_movement_coords).with(algebraic_coords)
    end
    # rubocop: enable all
  end
end
