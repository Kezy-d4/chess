# frozen_string_literal: true

require_relative '../lib/square'

describe Square do
  let(:piece) { double('piece') }

  describe '#update_occupant' do
    subject(:square_empty) { described_class.new }

    it 'updates the occupant' do
      square_empty.update_occupant(piece)
      expect(square_empty.occupant).to be(piece)
    end

    it 'returns the new occupant' do
      result = square_empty.update_occupant(piece)
      expect(result).to be(piece)
    end
  end

  describe '#remove_occupant' do
    subject(:square_occupied) { described_class.new(piece) }

    it 'removes the occupant' do
      square_occupied.remove_occupant
      expect(square_occupied.occupant).to be_nil
    end

    it 'returns the removed occupant' do
      result = square_occupied.remove_occupant
      expect(result).to be(piece)
    end
  end

  describe '#empty?' do
    context 'when the occupant is nil' do
      subject(:square_empty) { described_class.new }

      it 'returns true' do
        result = square_empty.empty?
        expect(result).to be(true)
      end
    end

    context 'when the occupant is not nil' do
      subject(:square_occupied) { described_class.new(piece) }

      it 'returns false' do
        result = square_occupied.empty?
        expect(result).to be(false)
      end
    end
  end

  describe '#occupied?' do
    context 'when the occupant is not nil' do
      subject(:square_occupied) { described_class.new(piece) }

      it 'returns true' do
        result = square_occupied.occupied?
        expect(result).to be(true)
      end
    end

    context 'when the occupant is nil' do
      subject(:square_empty) { described_class.new }

      it 'returns false' do
        result = square_empty.occupied?
        expect(result).to be(false)
      end
    end
  end
end
