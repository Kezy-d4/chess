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

  describe '#occupant_fen' do
    context 'when the occupant is a white king' do
      subject(:square_white_king) { described_class.new(white_king) }

      let(:white_king) { King.new(:white) }

      it 'returns "K"' do
        result = square_white_king.occupant_fen
        expect(result).to eq('K')
      end
    end

    context 'when the occupant is a black queen' do
      subject(:square_black_queen) { described_class.new(black_queen) }

      let(:black_queen) { Queen.new(:black) }

      it 'returns "q"' do
        result = square_black_queen.occupant_fen
        expect(result).to eq('q')
      end
    end
  end
end
