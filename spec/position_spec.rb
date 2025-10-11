# frozen_string_literal: true

require_relative '../lib/position'

describe Position do
  describe '#access_board_rank' do
    subject(:position_empty) { described_class.new }

    context 'when passed an in-bounds board rank index' do
      it 'returns a board rank object' do
        board_rank_index = 7
        result = position_empty.access_board_rank(board_rank_index)
        expect(result).to be_a(BoardRank)
      end
    end

    context 'when passed an out-of-bounds board rank index' do
      it 'returns nil' do
        invalid_board_rank_index = 8
        result = position_empty.access_board_rank(invalid_board_rank_index)
        expect(result).to be_nil
      end
    end
  end

  describe '#access_square' do
    subject(:position_empty) { described_class.new }

    context 'when passed in-bounds board rank and square indices' do
      it 'returns a square object' do
        board_rank_index = 7
        square_index = 7
        result = position_empty.access_square(board_rank_index, square_index)
        expect(result).to be_a(Square)
      end
    end

    context 'when passed an out-of-bounds board rank or square index' do
      it 'returns nil' do
        invalid_board_rank_index = 7
        square_index = 8
        result = position_empty.access_square(invalid_board_rank_index, square_index)
        expect(result).to be_nil
      end
    end
  end

  describe '#algebraic_to_index_coords' do
    context 'when passed algebraic coordinates "a1"' do
      it 'returns [0, 0]' do
        algebraic_coords = 'a1'
        result = described_class.algebraic_to_index_coords(algebraic_coords)
        expect(result).to eq([0, 0])
      end
    end

    context 'when passed algebraic coordinates "h8"' do
      it 'returns [7, 7]' do
        algebraic_coords = 'h8'
        result = described_class.algebraic_to_index_coords(algebraic_coords)
        expect(result).to eq([7, 7])
      end
    end

    context 'when passed algebraic coordinates "e4"' do
      it 'returns [3, 4]' do
        algebraic_coords = 'e4'
        result = described_class.algebraic_to_index_coords(algebraic_coords)
        expect(result).to eq([3, 4])
      end
    end
  end
end
