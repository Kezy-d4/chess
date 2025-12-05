# frozen_string_literal: true

require_relative '../lib/square'

describe Square do
  describe '#occupied?' do
    context 'when the square is occupied' do
      subject(:square_occupied) { described_class.new('a8', piece) }

      let(:piece) { double('piece') }

      it 'returns true' do
        result = square_occupied.occupied?
        expect(result).to be(true)
      end
    end

    context 'when the square is unoccupied' do
      subject(:square_unoccupied) { described_class.new('a8') }

      it 'returns false' do
        result = square_unoccupied.occupied?
        expect(result).to be(false)
      end
    end
  end

  describe '#unoccupied?' do
    context 'when the square is unoccupied' do
      subject(:square_unoccupied) { described_class.new('a8') }

      it 'returns true' do
        result = square_unoccupied.unoccupied?
        expect(result).to be(true)
      end
    end

    context 'when the square is occupied' do
      subject(:square_occupied) { described_class.new('a8', piece) }

      let(:piece) { double('piece') }

      it 'returns false' do
        result = square_occupied.unoccupied?
        expect(result).to be(false)
      end
    end
  end

  describe '#update_occupant' do
    subject(:square) { described_class.new('a8') }

    let(:piece) { double('piece') }

    it 'updates the occupant' do
      expect { square.update_occupant(piece) }.to change \
        { square.instance_variable_get(:@occupant) }.from(nil).to(piece)
    end

    it 'returns the new occupant' do
      result = square.update_occupant(piece)
      expect(result).to be(piece)
    end
  end

  describe '#remove_occupant' do
    subject(:square) { described_class.new('a8', piece) }

    let(:piece) { double('piece') }

    it 'removes the occupant' do
      expect { square.remove_occupant }.to change \
        { square.instance_variable_get(:@occupant) }.from(piece).to(nil)
    end

    it 'returns the removed occupant' do
      result = square.remove_occupant
      expect(result).to be(piece)
    end
  end

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
