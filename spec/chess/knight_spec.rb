# frozen_string_literal: true

describe Chess::Knight do
  describe '#generate_adjacent_movement_coords' do
    subject(:knight) { described_class.new(:white) }

    context 'when passed AlgebraicCoords e4' do
      let(:algebraic_coords_e4) { double('AlgebraicCoords') }

      let(:expected) do
        { north_east_left: %w[f6],
          north_east_right: %w[g5],
          south_east_left: %w[f2],
          south_east_right: %w[g3],
          south_west_left: %w[c3],
          south_west_right: %w[d2],
          north_west_left: %w[c5],
          north_west_right: %w[d6] }
      end

      before do
        allow(algebraic_coords_e4).to receive(:to_adjacency_string)
          .with(1, 2).and_return('f6')
        allow(algebraic_coords_e4).to receive(:to_adjacency_string)
          .with(2, 1).and_return('g5')
        allow(algebraic_coords_e4).to receive(:to_adjacency_string)
          .with(1, -2).and_return('f2')
        allow(algebraic_coords_e4).to receive(:to_adjacency_string)
          .with(2, -1).and_return('g3')
        allow(algebraic_coords_e4).to receive(:to_adjacency_string)
          .with(-2, -1).and_return('c3')
        allow(algebraic_coords_e4).to receive(:to_adjacency_string)
          .with(-1, -2).and_return('d2')
        allow(algebraic_coords_e4).to receive(:to_adjacency_string)
          .with(-2, 1).and_return('c5')
        allow(algebraic_coords_e4).to receive(:to_adjacency_string)
          .with(-1, 2).and_return('d6')
      end

      it 'returns a hash of adjacent coordinates per direction' do
        result = knight.generate_adjacent_movement_coords(algebraic_coords_e4)
        expect(result).to eq(expected)
      end
    end

    context 'when passed AlgebraicCoords a8' do
      let(:algebraic_coords_a8) { double('AlgebraicCoords') }

      let(:expected) do
        { south_east_left: %w[b6],
          south_east_right: %w[c7] }
      end

      before do
        allow(algebraic_coords_a8).to receive(:to_adjacency_string)
          .with(1, 2).and_return(nil)
        allow(algebraic_coords_a8).to receive(:to_adjacency_string)
          .with(2, 1).and_return(nil)
        allow(algebraic_coords_a8).to receive(:to_adjacency_string)
          .with(1, -2).and_return('b6')
        allow(algebraic_coords_a8).to receive(:to_adjacency_string)
          .with(2, -1).and_return('c7')
        allow(algebraic_coords_a8).to receive(:to_adjacency_string)
          .with(-2, -1).and_return(nil)
        allow(algebraic_coords_a8).to receive(:to_adjacency_string)
          .with(-1, -2).and_return(nil)
        allow(algebraic_coords_a8).to receive(:to_adjacency_string)
          .with(-2, 1).and_return(nil)
        allow(algebraic_coords_a8).to receive(:to_adjacency_string)
          .with(-1, 2).and_return(nil)
      end

      it 'returns a hash of adjacent coordinates per direction' do
        result = knight.generate_adjacent_movement_coords(algebraic_coords_a8)
        expect(result).to eq(expected)
      end
    end
  end

  describe '#generate_adjacent_capture_coords' do
    subject(:knight) { described_class.new(:white) }

    let(:algebraic_coords) { double('AlgebraicCoords') }

    # rubocop: disable RSpec/SubjectStub
    it 'sends the #generate_adjacent_movement_coords message to self with the passed AlgebraicCoords' do
      allow(knight).to receive(:generate_adjacent_movement_coords).with(algebraic_coords)
      knight.generate_adjacent_capture_coords(algebraic_coords)
      expect(knight).to have_received(:generate_adjacent_movement_coords).with(algebraic_coords)
    end
    # rubocop: enable all
  end
end
