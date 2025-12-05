# frozen_string_literal: true

require_relative '../lib/square'

describe Square do
  describe '#to_s' do
    context 'when the square is occupied' do
      subject(:square_occupied) { described_class.new('a8', piece) }

      let(:piece) { double('piece', to_s: expected_piece_str) }
      let(:expected_piece_str) do
        '<Piece>: [@algebraic_coords: a8, @color: white, @total_moves: 0]'
      end
      let(:expected_square_str) do
        "<Square>: [@algebraic_coords: a8, @occupant: #{expected_piece_str}]"
      end

      it 'returns a string describing the state of the square' do
        result = square_occupied.to_s
        expect(result).to eq(expected_square_str)
      end
    end

    context 'when the square is unoccupied' do
      subject(:square_unoccupied) { described_class.new('a8') }

      let(:expected) { '<Square>: [@algebraic_coords: a8, @occupant: ]' }

      it 'returns a string describing the state of the square' do
        result = square_unoccupied.to_s
        expect(result).to eq(expected)
      end
    end
  end
end
