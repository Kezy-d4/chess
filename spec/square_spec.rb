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
end
