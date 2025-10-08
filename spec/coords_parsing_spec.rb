# frozen_string_literal: true

require_relative '../lib/coords_parsing'

describe CoordsParsing do
  let(:dummy_class) { Class.new { extend CoordsParsing } }

  describe '#board_file_coord' do
    context 'when passed algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns "e"' do
        result = dummy_class.board_file_coord(algebraic_e4)
        expect(result).to eq('e')
      end
    end

    context 'when passed algebraic coordinates "h7"' do
      subject(:algebraic_h7) { 'h7' }

      it 'returns "h"' do
        result = dummy_class.board_file_coord(algebraic_h7)
        expect(result).to eq('h')
      end
    end

    context 'when passed numeric coordinates "54"' do
      subject(:numeric54) { '54' }

      it 'returns "5"' do
        result = dummy_class.board_file_coord(numeric54)
        expect(result).to eq('5')
      end
    end
  end

  describe '#board_rank_coord' do
    context 'when passed algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns "4"' do
        result = dummy_class.board_rank_coord(algebraic_e4)
        expect(result).to eq('4')
      end
    end

    context 'when passed algebraic coordinates "h7"' do
      subject(:algebraic_h7) { 'h7' }

      it 'returns "7"' do
        result = dummy_class.board_rank_coord(algebraic_h7)
        expect(result).to eq('7')
      end
    end

    context 'when passed numeric coordinates "54"' do
      subject(:numeric54) { '54' }

      it 'returns "4"' do
        result = dummy_class.board_rank_coord(numeric54)
        expect(result).to eq('4')
      end
    end
  end

  describe '#algebraic_to_numeric_coords' do
    context 'when passed algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns "54"' do
        result = dummy_class.algebraic_to_numeric_coords(algebraic_e4)
        expect(result).to eq('54')
      end
    end

    context 'when passed algebraic coordinates "h7"' do
      subject(:algebraic_h7) { 'h7' }

      it 'returns 87' do
        result = dummy_class.algebraic_to_numeric_coords(algebraic_h7)
        expect(result).to eq('87')
      end
    end
  end

  describe '#numeric_to_algebraic_coords' do
    context 'when passed numeric coordinates "54"' do
      subject(:numeric54) { '54' }

      it 'returns "e4"' do
        result = dummy_class.numeric_to_algebraic_coords(numeric54)
        expect(result).to eq('e4')
      end
    end

    context 'when passed numeric coordinates "87"' do
      subject(:numeric87) { '87' }

      it 'returns "h7"' do
        result = dummy_class.numeric_to_algebraic_coords(numeric87)
        expect(result).to eq('h7')
      end
    end

    context 'when passed numeric coordinates "88"' do
      subject(:numeric88) { '88' }

      it 'returns "h8"' do
        result = dummy_class.numeric_to_algebraic_coords(numeric88)
        expect(result).to eq('h8')
      end
    end
  end

  describe '#algebraic_coords_in_bounds?' do
    context 'when passed in-bounds algebraic coordinates "e4"' do
      subject(:algebraic_e4) { 'e4' }

      it 'returns true' do
        result = dummy_class.algebraic_coords_in_bounds?(algebraic_e4)
        expect(result).to be(true)
      end
    end

    context 'when passed out-of-bounds algebraic coordinates "h9"' do
      subject(:invalid_algebraic_h9) { 'h9' }

      it 'returns false' do
        result = dummy_class.algebraic_coords_in_bounds?(invalid_algebraic_h9)
        expect(result).to be(false)
      end
    end

    context 'when passed out-of-bounds algebraic coordinates "a0"' do
      subject(:invalid_algebraic_a0) { 'a0' }

      it 'returns false' do
        result = dummy_class.algebraic_coords_in_bounds?(invalid_algebraic_a0)
        expect(result).to be(false)
      end
    end

    context 'when passed out-of-bounds algebraic coordinates "i1"' do
      subject(:invalid_algebraic_i1) { 'i1' }

      it 'returns false' do
        result = dummy_class.algebraic_coords_in_bounds?(invalid_algebraic_i1)
        expect(result).to be(false)
      end
    end
  end

  describe '#numeric_coords_in_bounds?' do
    context 'when passed in-bounds numeric coordinates "54"' do
      subject(:numeric54) { '54' }

      it 'returns true' do
        result = dummy_class.numeric_coords_in_bounds?(numeric54)
        expect(result).to be(true)
      end
    end

    context 'when passed out-of-bounds numeric coordinates "89"' do
      subject(:invalid_numeric89) { '89' }

      it 'returns false' do
        result = dummy_class.numeric_coords_in_bounds?(invalid_numeric89)
        expect(result).to be(false)
      end
    end

    context 'when passed out-of-bounds numeric coordinates "01"' do
      subject(:invalid_numeric01) { '01' }

      it 'returns false' do
        result = dummy_class.numeric_coords_in_bounds?(invalid_numeric01)
        expect(result).to be(false)
      end
    end
  end
end
