# frozen_string_literal: true

require_relative '../lib/piece'

describe Piece do
  describe '#increment_total_moves' do
    subject(:piece) { described_class.new('a8', :white, 0) }

    it 'increments the piece\'s total moves by one' do
      piece.increment_total_moves
      incremented_total_moves = piece.instance_variable_get(:@total_moves)
      expect(incremented_total_moves).to eq(1)
    end
  end

  describe '#moved?' do
    context 'when the piece has moved at least once' do
      subject(:piece_moved) { described_class.new('a8', :white, 1) }

      it 'returns true' do
        result = piece_moved.moved?
        expect(result).to be(true)
      end
    end

    context 'when the piece has not moved' do
      subject(:piece_unmoved) { described_class.new('a8', :white, 0) }

      it 'returns false' do
        result = piece_unmoved.moved?
        expect(result).to be(false)
      end
    end
  end

  describe '#white?' do
    context 'when the piece is white' do
      subject(:piece_white) { described_class.new('a8', :white, 0) }

      it 'returns true' do
        result = piece_white.white?
        expect(result).to be(true)
      end
    end

    context 'when the piece is black' do
      subject(:piece_black) { described_class.new('a8', :black, 0) }

      it 'returns false' do
        result = piece_black.white?
        expect(result).to be(false)
      end
    end
  end

  describe '#black?' do
    context 'when the piece is black' do
      subject(:piece_black) { described_class.new('a8', :black, 0) }

      it 'returns true' do
        result = piece_black.black?
        expect(result).to be(true)
      end
    end

    context 'when the piece is white' do
      subject(:piece_white) { described_class.new('a8', :white, 0) }

      it 'returns false' do
        result = piece_white.black?
        expect(result).to be(false)
      end
    end
  end
end
