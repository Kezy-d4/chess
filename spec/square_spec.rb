# frozen_string_literal: true

require_relative '../lib/square'

describe Square do
  describe '#update_occupant' do
    subject(:square) { described_class.new('a8') }

    let(:piece) { double('piece') }

    it 'updates the occupant' do
      square.update_occupant(piece)
      updated_occupant = square.instance_variable_get(:@occupant)
      expect(updated_occupant).to be(piece)
    end

    it 'returns the new occupant' do
      result = square.update_occupant(piece)
      expect(result).to be(piece)
    end
  end

  describe '#remove_occupant' do
    subject(:square_occupied) { described_class.new('a8', piece) }

    let(:piece) { double('piece') }

    it 'removes any existing occupant' do
      square_occupied.remove_occupant
      occupant = square_occupied.instance_variable_get(:@occupant)
      expect(occupant).to be_nil
    end

    it 'returns the removed occupant' do
      result = square_occupied.remove_occupant
      expect(result).to be(piece)
    end
  end

  describe '#determine_bg_color' do
    context 'when the square\'s rank and file coordinates are both even' do
      subject(:square_even_coords) { described_class.new('b8') }

      it 'returns black' do
        result = square_even_coords.determine_bg_color
        expect(result).to eq(:black)
      end
    end

    context 'when the square\'s rank and file coordinates are both odd' do
      subject(:square_odd_coords) { described_class.new('a7') }

      it 'returns black' do
        result = square_odd_coords.determine_bg_color
        expect(result).to eq(:black)
      end
    end

    context 'when one of the square\'s coordinates is even and the other is odd' do
      subject(:square_diff_coords) { described_class.new('a8') }

      it 'returns white' do
        result = square_diff_coords.determine_bg_color
        expect(result).to eq(:white)
      end
    end
  end
end
