# frozen_string_literal: true

describe Square do
  describe '#occupied?' do
    context 'when the square is occupied' do
      subject(:square_occupied) { described_class.new(piece) }

      let(:piece) { double('piece') }

      it 'returns true' do
        result = square_occupied.occupied?
        expect(result).to be(true)
      end
    end

    context 'when the square is not occupied' do
      subject(:square_empty) { described_class.new }

      it 'returns false' do
        result = square_empty.occupied?
        expect(result).to be(false)
      end
    end
  end

  describe '#update_occupant' do
    subject(:square_occupied) { described_class.new(piece_one) }

    let(:piece_one) { double('piece_one') }
    let(:piece_two) { double('piece_two') }

    it 'updates the occupant' do
      square_occupied.update_occupant(piece_two)
      expect(square_occupied.instance_variable_get(:@occupant)).to be(piece_two)
    end

    it 'returns the new occupant' do
      result = square_occupied.update_occupant(piece_two)
      expect(result).to be(piece_two)
    end
  end

  describe '#remove occupant' do
    subject(:square_occupied) { described_class.new(piece) }

    let(:piece) { double('piece') }

    it 'removes any occupant' do
      square_occupied.remove_occupant
      expect(square_occupied.instance_variable_get(:@occupant)).to be_nil
    end

    it 'returns the removed occupant' do
      result = square_occupied.remove_occupant
      expect(result).to be(piece)
    end
  end

  describe '#occupant_is_white?' do
    context 'when the square is occupied' do
      subject(:square_occupied) { described_class.new(piece) }

      let(:piece) { double('piece') }

      it 'sends the message to the occupant to check if it is white' do
        allow(piece).to receive(:white?)
        square_occupied.occupant_is_white?
        expect(piece).to have_received(:white?)
      end
    end

    context 'when the square is not occupied' do
      subject(:square_empty) { described_class.new }

      it 'returns false' do
        result = square_empty.occupant_is_white?
        expect(result).to be(false)
      end
    end
  end

  describe '#occupant_is_black?' do
    context 'when the square is occupied' do
      subject(:square_occupied) { described_class.new(piece) }

      let(:piece) { double('piece') }

      it 'sends the message to the occupant to check if it is black' do
        allow(piece).to receive(:black?)
        square_occupied.occupant_is_black?
        expect(piece).to have_received(:black?)
      end
    end

    context 'when the square is not occupied' do
      subject(:square_empty) { described_class.new }

      it 'returns false' do
        result = square_empty.occupant_is_black?
        expect(result).to be(false)
      end
    end
  end
end
