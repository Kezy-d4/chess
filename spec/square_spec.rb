# frozen_string_literal: true

require_relative '../lib/square'

describe Square do
  describe '#empty?' do
    context 'when the occupant is nil' do
      subject(:square_empty) { described_class.new }

      it 'returns true' do
        result = square_empty.empty?
        expect(result).to be(true)
      end
    end

    context 'when the occupant is a piece' do
      subject(:square_occupied) { described_class.new(white_king) }

      let(:white_king) { King.new(:white) }

      it 'returns false' do
        result = square_occupied.empty?
        expect(result).to be(false)
      end
    end
  end

  describe '#occupied?' do
    context 'when the occupant is a piece' do
      subject(:square_occupied) { described_class.new(white_king) }

      let(:white_king) { King.new(:white) }

      it 'returns true' do
        result = square_occupied.occupied?
        expect(result).to be(true)
      end
    end

    context 'when the occupant is nil' do
      subject(:square_empty) { described_class.new }

      it 'returns false' do
        result = square_empty.occupied?
        expect(result).to be(false)
      end
    end
  end
end
