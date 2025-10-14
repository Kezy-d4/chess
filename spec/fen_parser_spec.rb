# frozen_string_literal: true

require_relative '../lib/fen_parser'

describe FenParser do
  describe '#data_fields' do
    context 'when testing the default fen record' do
      subject(:fen_parser_default) { described_class.new(ChessConstants::DEFAULT_FEN) }

      it 'returns an array of substrings representing each data field' do
        result = fen_parser_default.data_fields
        expected = ['rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR', 'w', 'KQkq', '-', '0', '1']
        expect(result).to eq(expected)
      end
    end
  end

  describe '#piece_placement_data' do
    context 'when testing the default fen record' do
      subject(:fen_parser_default) { described_class.new(ChessConstants::DEFAULT_FEN) }

      it 'returns a substring representing the piece placement data' do
        result = fen_parser_default.piece_placement_data
        expected = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR'
        expect(result).to eq(expected)
      end
    end
  end
end
