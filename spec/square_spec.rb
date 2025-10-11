# frozen_string_literal: true

require_relative '../lib/square'

describe Square do
  describe '#update_piece' do
    subject(:square_empty) { described_class.new }

    it 'updates the square\'s piece' do
      new_piece = King.new(:white)
      square_empty.update_piece(new_piece)
      expect(square_empty.piece).to be(new_piece)
    end
  end

  describe '#remove_piece' do
    subject(:square_occupied) { described_class.new(King.new(:white)) }

    it 'removes the square\'s piece' do
      square_occupied.remove_piece
      expect(square_occupied.piece).to be_nil
    end
  end

  describe '#empty?' do
    context 'when the square is empty' do
      subject(:square_empty) { described_class.new }

      it 'returns true' do
        result = square_empty.empty?
        expect(result).to be(true)
      end
    end

    context 'when the square is occupied' do
      subject(:square_occupied) { described_class.new(King.new(:white)) }

      it 'returns false' do
        result = square_occupied.empty?
        expect(result).to be(false)
      end
    end
  end

  describe '#occupied?' do
    context 'when the square is occupied' do
      subject(:square_occupied) { described_class.new(King.new(:white)) }

      it 'returns true' do
        result = square_occupied.occupied?
        expect(result).to be(true)
      end
    end

    context 'when the square is empty' do
      subject(:square_empty) { described_class.new }

      it 'returns false' do
        result = square_empty.occupied?
        expect(result).to be(false)
      end
    end
  end
end
