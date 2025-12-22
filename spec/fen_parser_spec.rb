# frozen_string_literal: true

require_relative '../lib/fen_parser'

describe FENParser do
  describe '#parse_piece_placement' do
    context 'when testing with the default fen record' do
      subject(:fen_parser_default) { described_class.new(ChessConstants::DEFAULT_FEN) }

      let(:expected) do
        { 8 => { a8: 'r', b8: 'n', c8: 'b', d8: 'q', e8: 'k', f8: 'b', g8: 'n', h8: 'r' },
          7 => { a7: 'p', b7: 'p', c7: 'p', d7: 'p', e7: 'p', f7: 'p', g7: 'p', h7: 'p' },
          6 => { a6: '-', b6: '-', c6: '-', d6: '-', e6: '-', f6: '-', g6: '-', h6: '-' },
          5 => { a5: '-', b5: '-', c5: '-', d5: '-', e5: '-', f5: '-', g5: '-', h5: '-' },
          4 => { a4: '-', b4: '-', c4: '-', d4: '-', e4: '-', f4: '-', g4: '-', h4: '-' },
          3 => { a3: '-', b3: '-', c3: '-', d3: '-', e3: '-', f3: '-', g3: '-', h3: '-' },
          2 => { a2: 'P', b2: 'P', c2: 'P', d2: 'P', e2: 'P', f2: 'P', g2: 'P', h2: 'P' },
          1 => { a1: 'R', b1: 'N', c1: 'B', d1: 'Q', e1: 'K', f1: 'B', g1: 'N', h1: 'R' } }
      end

      it 'returns the piece placement data parsed into a hash' do
        result = fen_parser_default.parse_piece_placement
        expect(result).to eq(expected)
      end
    end

    context 'when testing with an endgame fen record' do
      subject(:fen_parser_endgame) { described_class.new(endgame_fen) }

      let(:endgame_fen) { 'kq6/8/8/8/8/8/7P/7K w - - 0 65' }

      let(:expected) do
        { 8 => { a8: 'k', b8: 'q', c8: '-', d8: '-', e8: '-', f8: '-', g8: '-', h8: '-' },
          7 => { a7: '-', b7: '-', c7: '-', d7: '-', e7: '-', f7: '-', g7: '-', h7: '-' },
          6 => { a6: '-', b6: '-', c6: '-', d6: '-', e6: '-', f6: '-', g6: '-', h6: '-' },
          5 => { a5: '-', b5: '-', c5: '-', d5: '-', e5: '-', f5: '-', g5: '-', h5: '-' },
          4 => { a4: '-', b4: '-', c4: '-', d4: '-', e4: '-', f4: '-', g4: '-', h4: '-' },
          3 => { a3: '-', b3: '-', c3: '-', d3: '-', e3: '-', f3: '-', g3: '-', h3: '-' },
          2 => { a2: '-', b2: '-', c2: '-', d2: '-', e2: '-', f2: '-', g2: '-', h2: 'P' },
          1 => { a1: '-', b1: '-', c1: '-', d1: '-', e1: '-', f1: '-', g1: '-', h1: 'K' } }
      end

      it 'returns the piece placement data parsed into a hash' do
        result = fen_parser_endgame.parse_piece_placement
        expect(result).to eq(expected)
      end
    end
  end

  describe '#parse_data_fields' do
    context 'when testing with the default fen record' do
      subject(:fen_parser_default) { described_class.new(ChessConstants::DEFAULT_FEN) }

      let(:expected) do
        { piece_placement: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR',
          active_color: 'w',
          castling_availability: 'KQkq',
          en_passant_target: '-',
          half_move_clock: '0',
          full_move_number: '1' }
      end

      it 'returns the data fields parsed into a hash' do
        result = fen_parser_default.parse_data_fields
        expect(result).to eq(expected)
      end
    end

    context 'when testing with an endgame fen record' do
      subject(:fen_parser_endgame) { described_class.new(endgame_fen) }

      let(:endgame_fen) { 'kq6/8/8/8/8/8/7P/7K w - - 0 65' }

      let(:expected) do
        { piece_placement: 'kq6/8/8/8/8/8/7P/7K',
          active_color: 'w',
          castling_availability: '-',
          en_passant_target: '-',
          half_move_clock: '0',
          full_move_number: '65' }
      end

      it 'returns the data fields parsed into a hash' do
        result = fen_parser_endgame.parse_data_fields
        expect(result).to eq(expected)
      end
    end
  end
end
