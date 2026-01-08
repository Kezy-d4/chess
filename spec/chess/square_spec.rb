# frozen_string_literal: true

describe Chess::Square do
  describe '#occupied?' do
    context 'when the Square is occupied' do
      subject(:square_occupied) { described_class.new(piece) }

      let(:piece) { double('Piece') }

      it 'returns true' do
        result = square_occupied.occupied?
        expect(result).to be(true)
      end
    end

    context 'when the Square is unoccupied' do
      subject(:square_unoccupied) { described_class.new('-') }

      it 'returns false' do
        result = square_unoccupied.occupied?
        expect(result).to be(false)
      end
    end
  end

  describe '#unoccupied?' do
    context 'when the Square is unoccupied' do
      subject(:square_unoccupied) { described_class.new('-') }

      it 'returns true' do
        result = square_unoccupied.unoccupied?
        expect(result).to be(true)
      end
    end

    context 'when the Square is occupied' do
      subject(:square_occupied) { described_class.new(piece) }

      let(:piece) { double('Piece') }

      it 'returns false' do
        result = square_occupied.unoccupied?
        expect(result).to be(false)
      end
    end
  end

  describe '#update_occupant' do
    subject(:square) { described_class.new('-') }

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
    subject(:square) { described_class.new(piece) }

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

  describe '#to_class_s' do
    subject(:square) { described_class.new('-') }

    it 'returns a class string' do
      result = square.to_class_s
      expect(result).to eq('Square')
    end
  end

  describe '#to_s' do
    context 'when the Square is occupied' do
      subject(:square_occupied) { described_class.new(piece) }

      let(:piece) { Chess::Piece.new(:white) }
      let(:expected) do
        "The Square is occupied by a Piece.\n" \
          "\s\sThe Piece is white and has not moved."
      end

      it 'returns a string describing the state' do
        result = square_occupied.to_s
        expect(result).to eq(expected)
      end
    end

    context 'when the Square is unoccupied' do
      subject(:square_unoccupied) { described_class.new('-') }

      let(:expected) { 'The Square is unoccupied.' }

      it 'returns a string describing the state' do
        result = square_unoccupied.to_s
        expect(result).to eq(expected)
      end
    end
  end
end
