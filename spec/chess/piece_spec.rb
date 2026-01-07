# frozen_string_literal: true

# NOTE: For this spec and its sub-specs, if the color parameter is not relevant
# to the specific test, then we always set it to :white as a placeholder.
# Additionally, it's important to know that the total_moves parameter always
# defaults to 0.
describe Chess::Piece do
  describe '#white?' do
    context 'when the Piece is white' do
      subject(:piece_white) { described_class.new(:white) }

      it 'returns true' do
        result = piece_white.white?
        expect(result).to be(true)
      end
    end

    context 'when the Piece is black' do
      subject(:piece_black) { described_class.new(:black) }

      it 'returns false' do
        result = piece_black.white?
        expect(result).to be(false)
      end
    end
  end

  describe '#black?' do
    context 'when the Piece is black' do
      subject(:piece_black) { described_class.new(:black) }

      it 'returns true' do
        result = piece_black.black?
        expect(result).to be(true)
      end
    end

    context 'when the Piece is white' do
      subject(:piece_white) { described_class.new(:white) }

      it 'returns false' do
        result = piece_white.black?
        expect(result).to be(false)
      end
    end
  end

  describe '#moved?' do
    context 'when the Piece has moved at least once' do
      subject(:piece_moved) { described_class.new(:white, 1) }

      it 'returns true' do
        result = piece_moved.moved?
        expect(result).to be(true)
      end
    end

    context 'when the the Piece has not moved' do
      subject(:piece_unmoved) { described_class.new(:white) }

      it 'returns false' do
        result = piece_unmoved.moved?
        expect(result).to be(false)
      end
    end
  end

  describe '#moved_once?' do
    context 'when the Piece has moved exactly once' do
      subject(:piece_moved_once) { described_class.new(:white, 1) }

      it 'returns true' do
        result = piece_moved_once.moved_once?
        expect(result).to be(true)
      end
    end

    context 'when the Piece has moved more than once' do
      subject(:piece_moved_multiple_times) { described_class.new(:white, 2) }

      it 'returns false' do
        result = piece_moved_multiple_times.moved_once?
        expect(result).to be(false)
      end
    end

    context 'when the Piece has not moved' do
      subject(:piece_unmoved) { described_class.new(:white) }

      it 'returns false' do
        result = piece_unmoved.moved_once?
        expect(result).to be(false)
      end
    end
  end

  describe '#moved_more_than_once?' do
    context 'when the Piece has moved more than once' do
      subject(:piece_moved_multiple_times) { described_class.new(:white, 2) }

      it 'returns true' do
        result = piece_moved_multiple_times.moved_more_than_once?
        expect(result).to be(true)
      end
    end

    context 'when the Piece has moved exactly once' do
      subject(:piece_moved_once) { described_class.new(:white, 1) }

      it 'returns false' do
        result = piece_moved_once.moved_more_than_once?
        expect(result).to be(false)
      end
    end

    context 'when the Piece has not moved' do
      subject(:piece_unmoved) { described_class.new(:white) }

      it 'returns false' do
        result = piece_unmoved.moved_more_than_once?
        expect(result).to be(false)
      end
    end
  end

  describe '#unmoved?' do
    context 'when the Piece has not moved' do
      subject(:piece_unmoved) { described_class.new(:white) }

      it 'returns true' do
        result = piece_unmoved.unmoved?
        expect(result).to be(true)
      end
    end

    context 'when the Piece has moved at least once' do
      subject(:piece_moved) { described_class.new(:white, 1) }

      it 'returns false' do
        result = piece_moved.unmoved?
        expect(result).to be(false)
      end
    end
  end

  describe '#increment_total_moves' do
    subject(:piece) { described_class.new(:white) }

    it 'increments the total moves by one' do
      expect { piece.increment_total_moves }.to change \
        { piece.instance_variable_get(:@total_moves) }.from(0).to(1)
    end
  end

  describe '#to_class_s' do
    subject(:piece) { described_class.new(:white) }

    it 'returns a class string' do
      result = piece.to_class_s
      expect(result).to eq('Piece')
    end
  end

  describe '#to_s' do
    context 'when the Piece has not moved' do
      subject(:piece_unmoved) { described_class.new(:white) }

      it 'returns a string describing the state' do
        result = piece_unmoved.to_s
        expect(result).to eq('The Piece is white and has not moved.')
      end
    end

    context 'when the Piece has moved exactly once' do
      subject(:piece_moved_once) { described_class.new(:white, 1) }

      it 'returns a string describing the state' do
        result = piece_moved_once.to_s
        expect(result).to eq('The Piece is white and has moved 1 time.')
      end
    end

    context 'when the Piece has moved more than once' do
      subject(:piece_moved_multiple_times) { described_class.new(:white, 8) }

      it 'returns a string describing the state' do
        result = piece_moved_multiple_times.to_s
        expect(result).to eq('The Piece is white and has moved 8 times.')
      end
    end
  end
end
