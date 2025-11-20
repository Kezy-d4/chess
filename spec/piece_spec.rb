# frozen_string_literal: true

require_relative '../lib/piece'

describe Piece do
  describe '#increment_total_moves' do
    subject(:piece) { described_class.new('a8', :white, 0) }

    it 'increments the total moves' do
      piece.increment_total_moves
      incremented_total_moves = piece.instance_variable_get(:@total_moves)
      expect(incremented_total_moves).to eq(1)
    end
  end

  describe '#update_algebraic_coords' do
    subject(:piece) { described_class.new('a8', :white, 0) }

    it 'updates the algebraic coordinates' do
      new_algebraic_coords = 'b8'
      piece.update_algebraic_coords(new_algebraic_coords)
      updated_algebraic_coords = piece.instance_variable_get(:@algebraic_coords)
      expect(updated_algebraic_coords).to be(new_algebraic_coords)
    end

    it 'returns the new algebraic coordinates' do
      new_algebraic_coords = 'b8'
      result = piece.update_algebraic_coords(new_algebraic_coords)
      expect(result).to be(new_algebraic_coords)
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
