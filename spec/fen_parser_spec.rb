# frozen_string_literal: true

require_relative '../lib/fen_parser'

describe FenParser do
  describe '#split_fen' do
    context 'when testing with the default fen record' do
      subject(:fen_parser_default) { described_class.new(Constants::DEFAULT_FEN) }

      let(:expected) do
        { piece_placement: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR',
          active_color: 'w',
          castling_availability: 'KQkq',
          en_passant_target: '-',
          half_move_clock: '0',
          full_move_number: '1' }
      end

      it 'returns a hash storing each data field as a string' do
        result = fen_parser_default.split_fen
        expect(result).to eq(expected)
      end
    end
  end
end
