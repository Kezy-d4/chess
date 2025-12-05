# frozen_string_literal: true

require_relative '../lib/piece'

describe Piece do
  describe '#white?' do
    context 'when the piece is white' do
      subject(:piece_white) { described_class.new('a8', :white) }

      it 'returns true' do
        result = piece_white.white?
        expect(result).to be(true)
      end
    end

    context 'when the piece is black' do
      subject(:piece_black) { described_class.new('a8', :black) }

      it 'returns false' do
        result = piece_black.white?
        expect(result).to be(false)
      end
    end
  end

  describe '#black?' do
    context 'when the piece is black' do
      subject(:piece_black) { described_class.new('a8', :black) }

      it 'returns true' do
        result = piece_black.black?
        expect(result).to be(true)
      end
    end

    context 'when the piece is white' do
      subject(:piece_white) { described_class.new('a8', :white) }

      it 'returns false' do
        result = piece_white.black?
        expect(result).to be(false)
      end
    end
  end

  describe '#update_algebraic_coords' do
    subject(:piece) { described_class.new('a8', :white) }

    it 'updates the algebraic coordinates' do
      expect { piece.update_algebraic_coords('b7') }.to change \
        { piece.instance_variable_get(:@algebraic_coords) }.from('a8').to('b7')
    end

    it 'returns the new algebraic coordinates' do
      result = piece.update_algebraic_coords('b7')
      expect(result).to eq('b7')
    end
  end

  describe '#increment_total_moves' do
    subject(:piece) { described_class.new('a8', :white) }

    it 'increments the total moves by one' do
      expect { piece.increment_total_moves }.to change \
        { piece.instance_variable_get(:@total_moves) }.from(0).to(1)
    end
  end

  describe '#to_s' do
    subject(:piece) { described_class.new('a8', :white) }

    let(:expected) do
      '<Piece>: [@algebraic_coords: a8, @color: white, @total_moves: 0]'
    end

    it 'returns a string describing the state of the piece' do
      result = piece.to_s
      expect(result).to eq(expected)
    end
  end
end
