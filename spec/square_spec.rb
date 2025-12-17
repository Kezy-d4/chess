# frozen_string_literal: true

require_relative '../lib/square'

describe Square do
  describe '#occupied?' do
    context 'when the square is occupied' do
      subject(:square_occupied) { described_class.new(algebraic_coords, piece) }

      let(:algebraic_coords) { double('AlgebraicCoords') }
      let(:piece) { double('Piece') }

      it 'returns true' do
        result = square_occupied.occupied?
        expect(result).to be(true)
      end
    end

    context 'when the square is unoccupied' do
      subject(:square_unoccupied) { described_class.new(algebraic_coords, '-') }

      let(:algebraic_coords) { double('AlgebraicCoords') }

      it 'returns false' do
        result = square_unoccupied.occupied?
        expect(result).to be(false)
      end
    end
  end

  describe '#unoccupied?' do
    context 'when the square is unoccupied' do
      subject(:square_unoccupied) { described_class.new(algebraic_coords, '-') }

      let(:algebraic_coords) { double('AlgebraicCoords') }

      it 'returns true' do
        result = square_unoccupied.unoccupied?
        expect(result).to be(true)
      end
    end

    context 'when the square is occupied' do
      subject(:square_occupied) { described_class.new(algebraic_coords, piece) }

      let(:algebraic_coords) { double('AlgebraicCoords') }
      let(:piece) { double('Piece') }

      it 'returns false' do
        result = square_occupied.unoccupied?
        expect(result).to be(false)
      end
    end
  end

  describe '#update_occupant' do
    subject(:square) { described_class.new(algebraic_coords, '-') }

    let(:algebraic_coords) { double('AlgebraicCoords') }
    let(:piece) { double('Piece') }

    it 'updates the occupant' do
      expect { square.update_occupant(piece) }.to change \
        { square.instance_variable_get(:@occupant) }.from('-').to(piece)
    end

    it 'returns the new occupant' do
      result = square.update_occupant(piece)
      expect(result).to be(piece)
    end
  end

  describe '#remove_occupant' do
    subject(:square) { described_class.new(algebraic_coords, piece) }

    let(:algebraic_coords) { double('AlgebraicCoords') }
    let(:piece) { double('Piece') }

    it 'removes the occupant' do
      expect { square.remove_occupant }.to change \
        { square.instance_variable_get(:@occupant) }.from(piece).to('-')
    end

    it 'returns the removed occupant' do
      result = square.remove_occupant
      expect(result).to be(piece)
    end
  end
end
