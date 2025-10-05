# frozen_string_literal: true

require_relative '../lib/position'

describe Position do
  let(:initial_fen) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }
  let(:initial_position) { described_class.from_fen(initial_fen) }

  describe '#access_square' do
    context 'when accessing square d8 of the initial chess position' do
      subject { initial_position }

      it 'returns a square object' do
        result = initial_position.access_square(:d8)
        expect(result).to be_a(Square)
      end

      it 'the square occupant is a queen object' do
        result = initial_position.access_square(:d8)
        expect(result.occupant).to be_a(Queen)
      end

      it 'the square occupant is black' do
        result = initial_position.access_square(:d8)
        expect(result.occupant.color).to eq(:black)
      end
    end
  end
end
