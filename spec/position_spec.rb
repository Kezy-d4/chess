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
end
