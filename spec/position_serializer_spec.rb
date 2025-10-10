# frozen_string_literal: true

require_relative '../lib/position_serializer'

describe PositionSerializer do
  let(:initial_fen) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }
  let(:initial_position) { Position.from_fen(initial_fen) }

  describe '#serialize_position' do
    context 'when testing the initial chess position' do
      subject(:position_serializer_initial) { described_class.new(initial_position) }

      it 'returns the piece placement data of the position as a string in FEN format' do
        result = position_serializer_initial.serialize_position
        expected = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR'
        expect(result).to eq(expected)
      end
    end
  end
end
