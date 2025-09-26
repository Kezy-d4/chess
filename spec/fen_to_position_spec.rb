# frozen_string_literal: true

require_relative '../lib/fen_to_position'

describe FenToPosition do
  context 'when the fen record represents the initial chess position' do
    subject(:fen_str) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }

    describe '#fen_to_position' do
      let(:expected) do
        [%w[r n b q k b n r],
         %w[p p p p p p p p],
         [nil, nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil, nil, nil],
         %w[P P P P P P P P],
         %w[R N B Q K B N R]]
      end

      it 'returns the piece placement data of a fen record translated into a nested array' do
        result = described_class.fen_to_position(fen_str)
        expect(result).to eq(expected)
      end
    end
  end
end
