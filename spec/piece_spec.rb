# frozen_string_literal: true

require_relative '../lib/piece'

describe Piece do
  describe '#black?' do
    context 'when the piece is black' do
      subject(:piece_black) { described_class.new(:black) }

      it 'returns true' do
        result = piece_black.black?
        expect(result).to be(true)
      end
    end

    context 'when the piece is white' do
      subject(:piece_white) { described_class.new(:white) }

      it 'returns false' do
        result = piece_white.black?
        expect(result).to be(false)
      end
    end
  end

  describe '#white?' do
    context 'when the piece is white' do
      subject(:piece_white) { described_class.new(:white) }

      it 'returns true' do
        result = piece_white.white?
        expect(result).to be(true)
      end
    end

    context 'when the piece is black' do
      subject(:piece_black) { described_class.new(:black) }

      it 'returns false' do
        result = piece_black.white?
        expect(result).to be(false)
      end
    end
  end
end
