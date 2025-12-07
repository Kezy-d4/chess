# frozen_string_literal: true

require_relative '../../lib/pieces/pawn'

describe Pawn do
  describe '#generate_adjacent_movement_coords' do
    context 'when the pawn is white and has not moved from coordinates e2' do
      subject(:pawn_white_unmoved) { described_class.new('e2', :white) }

      let(:expected) { { n: %w[e3 e4] } }

      it 'returns a hash of adjacent coordinates' do
        result = pawn_white_unmoved.generate_adjacent_movement_coords
        expect(result).to eq(expected)
      end
    end

    context 'when the pawn is white, has moved, and has coordinates e4' do
      subject(:pawn_white_moved) { described_class.new('e4', :white, 1) }

      let(:expected) { { n: %w[e5] } }

      it 'returns a hash of adjacent coordinates' do
        result = pawn_white_moved.generate_adjacent_movement_coords
        expect(result).to eq(expected)
      end
    end

    context 'when the pawn is white, has moved, and has coordinates e8' do
      subject(:pawn_white_moved_edge) { described_class.new('e8', :white, 5) }

      it 'returns an empty hash' do
        result = pawn_white_moved_edge.generate_adjacent_movement_coords
        expect(result).to be_a(Hash).and be_empty
      end
    end

    context 'when the pawn is black and has not moved from coordinates e7' do
      subject(:pawn_black_unmoved) { described_class.new('e7', :black) }

      let(:expected) { { s: %w[e6 e5] } }

      it 'returns a hash of adjacent coordinates' do
        result = pawn_black_unmoved.generate_adjacent_movement_coords
        expect(result).to eq(expected)
      end
    end

    context 'when the pawn is black, has moved, and has coordinates e5' do
      subject(:pawn_black_moved) { described_class.new('e5', :black, 1) }

      let(:expected) { { s: %w[e4] } }

      it 'returns a hash of adjacent coordinates' do
        result = pawn_black_moved.generate_adjacent_movement_coords
        expect(result).to eq(expected)
      end
    end

    context 'when the pawn is black, has moved, and has coordinates e1' do
      subject(:pawn_black_moved_edge) { described_class.new('e1', :black, 5) }

      it 'returns an empty hash' do
        result = pawn_black_moved_edge.generate_adjacent_movement_coords
        expect(result).to be_a(Hash).and be_empty
      end
    end
  end

  describe '#generate_adjacent_capture_coords' do
    context 'when the pawn is white and has coordinates e2' do
      subject(:pawn_white_full_capture) { described_class.new('e2', :white) }

      let(:expected) { { n_w: %w[d3], n_e: %w[f3] } }

      it 'returns a hash of adjacent coordinates' do
        result = pawn_white_full_capture.generate_adjacent_capture_coords
        expect(result).to eq(expected)
      end
    end

    context 'when the pawn is white and has coordinates a2' do
      subject(:pawn_white_right_capture) { described_class.new('a2', :white) }

      let(:expected) { { n_e: %w[b3] } }

      it 'returns a hash of adjacent coordinates' do
        result = pawn_white_right_capture.generate_adjacent_capture_coords
        expect(result).to eq(expected)
      end
    end

    context 'when the pawn is white and has coordinates h2' do
      subject(:pawn_white_left_capture) { described_class.new('h2', :white) }

      let(:expected) { { n_w: %w[g3] } }

      it 'returns a hash of adjacent coordinates' do
        result = pawn_white_left_capture.generate_adjacent_capture_coords
        expect(result).to eq(expected)
      end
    end

    context 'when the pawn is white and has coordinates e8' do
      subject(:pawn_white_no_capture) { described_class.new('e8', :white) }

      it 'returns an empty hash' do
        result = pawn_white_no_capture.generate_adjacent_capture_coords
        expect(result).to be_a(Hash).and be_empty
      end
    end

    context 'when the pawn is black and has coordinates e7' do
      subject(:pawn_black_full_capture) { described_class.new('e7', :black) }

      let(:expected) { { s_w: %w[d6], s_e: %w[f6] } }

      it 'returns a hash of adjacent coordinates' do
        result = pawn_black_full_capture.generate_adjacent_capture_coords
        expect(result).to eq(expected)
      end
    end

    context 'when the pawn is black and has coordinates a7' do
      subject(:pawn_black_right_capture) { described_class.new('a7', :black) }

      let(:expected) { { s_e: %w[b6] } }

      it 'returns a hash of adjacent coordinates' do
        result = pawn_black_right_capture.generate_adjacent_capture_coords
        expect(result).to eq(expected)
      end
    end

    context 'when the pawn is black and has coordinates h7' do
      subject(:pawn_black_left_capture) { described_class.new('h7', :black) }

      let(:expected) { { s_w: %w[g6] } }

      it 'returns a hash of adjacent coordinates' do
        result = pawn_black_left_capture.generate_adjacent_capture_coords
        expect(result).to eq(expected)
      end
    end

    context 'when the pawn is black and has coordinates e1' do
      subject(:pawn_black_no_capture) { described_class.new('e1', :black) }

      it 'returns an empty hash' do
        result = pawn_black_no_capture.generate_adjacent_capture_coords
        expect(result).to be_a(Hash).and be_empty
      end
    end
  end
end
