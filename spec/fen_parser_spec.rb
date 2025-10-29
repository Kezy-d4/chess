# frozen_string_literal: true

require_relative '../lib/fen_parser'

describe FenParser do
  describe '#parse_fen' do
    context 'when testing with the default fen record' do
      subject(:fen_parser_default) { described_class.new(default_fen) }

      let(:default_fen) { Constants::DEFAULT_FEN }

      it 'returns a hash that stores a string of the piece placement data' do
        result = fen_parser_default.parse_fen[:piece_placement]
        expected = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR'
        expect(result).to eq(expected)
      end

      it 'returns a hash that stores a string of the active color data' do
        result = fen_parser_default.parse_fen[:active_color]
        expected = 'w'
        expect(result).to eq(expected)
      end

      it 'returns a hash that stores a string of the castling availability data' do
        result = fen_parser_default.parse_fen[:castling_availability]
        expected = 'KQkq'
        expect(result).to eq(expected)
      end

      it 'returns a hash that stores a string of the en passant target data' do
        result = fen_parser_default.parse_fen[:en_passant_target]
        expected = '-'
        expect(result).to eq(expected)
      end

      it 'returns a hash that stores a string of the half move clock data' do
        result = fen_parser_default.parse_fen[:half_move_clock]
        expected = '0'
        expect(result).to eq(expected)
      end

      it 'returns a hash that stores a string of the full move number data' do
        result = fen_parser_default.parse_fen[:full_move_number]
        expected = '1'
        expect(result).to eq(expected)
      end
    end
  end
end
