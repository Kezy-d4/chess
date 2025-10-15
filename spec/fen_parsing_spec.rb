# frozen_string_literal: true

require_relative '../lib/fen_parsing'

describe FenParsing do
  let(:dummy_class) { Class.new { extend FenParsing } }

  describe '#data_fields' do
    context 'when testing the default fen record' do
      subject(:fen_default) { ChessConstants::DEFAULT_FEN }

      it 'returns an array of substrings representing each data field' do
        result = dummy_class.data_fields(fen_default)
        expected = %w[rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1]
        expect(result).to eq(expected)
      end
    end
  end

  describe '#piece_placement_data' do
    context 'when testing the default fen record' do
      subject(:fen_default) { ChessConstants::DEFAULT_FEN }

      it 'returns a substring representing the piece placement data field' do
        result = dummy_class.piece_placement_data(fen_default)
        expected = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#piece_placement_data_of_ranks' do
    context 'when testing the default fen record' do
      subject(:fen_default) { ChessConstants::DEFAULT_FEN }

      it 'returns an array of substrings representing the piece placement data of each rank' do
        result = dummy_class.piece_placement_data_of_ranks(fen_default)
        expected = %w[rnbqkbnr pppppppp 8 8 8 8 PPPPPPPP RNBQKBNR]
        expect(result).to eq(expected)
      end
    end
  end
end
