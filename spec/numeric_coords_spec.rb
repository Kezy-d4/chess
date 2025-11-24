# frozen_string_literal: true

require_relative '../lib/numeric_coords'

describe NumericCoords do
  describe '#format' do
    context 'when testing with coordinates 18 (algebraic: a8)' do
      subject(:numeric_coords) { described_class.new(1, 8) }

      it 'returns the coordinates formatted into a hash' do
        result = numeric_coords.format
        expect(result).to eq({ file: 1, rank: 8 })
      end
    end
  end

  describe '#translate_to_algebraic' do
    context 'when testing with coordinates 18 (algebraic: a8)' do
      subject(:numeric_coords) { described_class.new(1, 8) }

      it 'returns the algebraic equivalent formatted into a hash' do
        result = numeric_coords.translate_to_algebraic
        expect(result).to eq({ file: 'a', rank: 8 })
      end
    end

    context 'when testing with coordinates 88 (algebraic: h8)' do
      subject(:numeric_coords) { described_class.new(8, 8) }

      it 'returns the algebraic equivalent formatted into a hash' do
        result = numeric_coords.translate_to_algebraic
        expect(result).to eq({ file: 'h', rank: 8 })
      end
    end
  end

  describe '#adjust' do
    subject(:numeric_coords) { described_class.new(1, 8) }

    before { numeric_coords.adjust(1, -1) }

    it 'updates the file coordinate' do
      file = numeric_coords.instance_variable_get(:@file)
      expect(file).to eq(2)
    end

    it 'updates the rank coordinate' do
      rank = numeric_coords.instance_variable_get(:@rank)
      expect(rank).to eq(7)
    end
  end

  describe '#in_bounds?' do
    context 'when both the file and rank coordinates are in bounds' do
      subject(:numeric_coords) { described_class.new(1, 8) }

      it 'returns true' do
        result = numeric_coords.in_bounds?
        expect(result).to be(true)
      end
    end

    context 'when the file coordinate is not in bounds' do
      subject(:numeric_coords) { described_class.new(0, 8) }

      it 'returns false' do
        result = numeric_coords.in_bounds?
        expect(result).to be(false)
      end
    end

    context 'when the rank coordinate is not in bounds' do
      subject(:numeric_coords) { described_class.new(1, 0) }

      it 'returns false' do
        result = numeric_coords.in_bounds?
        expect(result).to be(false)
      end
    end

    context 'when neither the file nor the rank coordinates are in bounds' do
      subject(:numeric_coords) { described_class.new(9, 9) }

      it 'returns false' do
        result = numeric_coords.in_bounds?
        expect(result).to be(false)
      end
    end
  end
end
