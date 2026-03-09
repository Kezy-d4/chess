# frozen_string_literal: true

describe Chess::Piece do
  describe '#white?' do
    context 'when white' do
      subject(:piece_white) { described_class.new(:white) }

      it 'returns true' do
        result = piece_white.white?
        expect(result).to be(true)
      end
    end

    context 'when black' do
      subject(:piece_black) { described_class.new(:black) }

      it 'returns false' do
        result = piece_black.white?
        expect(result).to be(false)
      end
    end
  end

  describe '#black?' do
    context 'when black' do
      subject(:piece_black) { described_class.new(:black) }

      it 'returns true' do
        result = piece_black.black?
        expect(result).to be(true)
      end
    end

    context 'when white' do
      subject(:piece_white) { described_class.new(:white) }

      it 'returns false' do
        result = piece_white.black?
        expect(result).to be(false)
      end
    end
  end

  describe '#to_s' do
    subject(:piece) { described_class.new(:white) }

    it 'returns a string describing the state' do
      result = piece.to_s
      expect(result).to eq('The Piece is white.')
    end
  end
end
