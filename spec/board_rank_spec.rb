# frozen_string_literal: true

require_relative '../lib/board_rank'

describe BoardRank do
  describe '#access_square' do
    subject(:board_rank_empty) { described_class.new }

    context 'when passed an in-bounds square index' do
      it 'returns a square object' do
        square_index = 7
        result = board_rank_empty.access_square(square_index)
        expect(result).to be_a(Square)
      end
    end

    context 'when passed an out-of-bounds square index' do
      it 'returns nil' do
        invalid_square_index = 8
        result = board_rank_empty.access_square(invalid_square_index)
        expect(result).to be_nil
      end
    end
  end
end
