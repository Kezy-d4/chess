# frozen_string_literal: true

require_relative '../lib/coords_processing'

describe CoordsProcessing do
  let(:dummy_class) { Class.new { extend CoordsProcessing } }

  describe '#vertical_adjacent_coords' do
    context 'when passed algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of vertical adjacent coordinates' do
        result = dummy_class.vertical_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[e1 e2 e3 e5 e6 e7 e8])
      end
    end
  end

  describe '#horizontal_adjacent_coords' do
    context 'when passed algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of horizontal adjacent coordinates' do
        result = dummy_class.horizontal_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[a4 b4 c4 d4 f4 g4 h4])
      end
    end
  end

  describe '#top_left_diagonal_adjacent_coords' do
    context 'when passed algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns an array of top left diagonal adjacent coordinates' do
        result = dummy_class.top_left_diagonal_adjacent_coords(algebraic_e4)
        expect(result).to match_array(%w[a8 b7 c6 d5])
      end
    end
  end
end
