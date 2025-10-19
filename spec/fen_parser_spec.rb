# frozen_string_literal: true

require_relative '../lib/fen_parser'

describe FenParser do
  let(:dummy_class) { Class.new { extend FenParser } }

  describe '#parse_fen_record' do
    context 'when parsing the default fen record' do
      subject(:fen_default) { ChessConstants::DEFAULT_FEN }

      it 'returns a hash' do
        result = dummy_class.parse_fen_record(fen_default)
        expect(result).to be_a(Hash)
      end

      it 'stores a substring of the piece placement data field' do
        result = dummy_class.parse_fen_record(fen_default)[:piece_placement_data]
        expected = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#parse_data_fields' do
    context 'when parsing the default fen record' do
      subject(:fen_default) { ChessConstants::DEFAULT_FEN }

      it 'returns an array of substrings of each data field' do
        result = dummy_class.parse_data_fields(fen_default)
        expected = %w[rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1]
        expect(result).to eq(expected)
      end
    end
  end

  describe '#parse_piece_placement' do
    context 'when parsing the default fen record' do
      subject(:fen_default) { ChessConstants::DEFAULT_FEN }

      it 'returns a substring of the piece placement data field' do
        result = dummy_class.parse_piece_placement(fen_default)
        expected = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#parse_active_color' do
    context 'when parsing the default fen record' do
      subject(:fen_default) { ChessConstants::DEFAULT_FEN }

      it 'returns a substring of the active color data field' do
        result = dummy_class.parse_active_color(fen_default)
        expected = 'w'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#parse_castling_availability' do
    context 'when parsing the default fen record' do
      subject(:fen_default) { ChessConstants::DEFAULT_FEN }

      it 'returns a substring of the castling availability data field' do
        result = dummy_class.parse_castling_availability(fen_default)
        expected = 'KQkq'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#parse_en_passant_target_square' do
    context 'when parsing the default fen record' do
      subject(:fen_default) { ChessConstants::DEFAULT_FEN }

      it 'returns a substring of the en passant target square data field' do
        result = dummy_class.parse_en_passant_target_square(fen_default)
        expected = '-'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#parse_half_move_clock' do
    context 'when parsing the default fen record' do
      subject(:fen_default) { ChessConstants::DEFAULT_FEN }

      it 'returns a substring of the half move clock data field' do
        result = dummy_class.parse_half_move_clock(fen_default)
        expected = '0'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#parse_full_move_number' do
    context 'when parsing the default fen record' do
      subject(:fen_default) { ChessConstants::DEFAULT_FEN }

      it 'returns a substring of the full move number data field' do
        result = dummy_class.parse_full_move_number(fen_default)
        expected = '1'
        expect(result).to eq(expected)
      end
    end
  end

  describe '#char_represents_white_piece?' do
    context 'when parsing a character that represents a white piece' do
      subject(:char_white_king) { 'K' }

      it 'returns true' do
        result = dummy_class.char_represents_white_piece?(char_white_king)
        expect(result).to be(true)
      end
    end

    context 'when parsing a character that does not represent a white piece' do
      subject(:char_black_king) { 'k' }

      it 'returns false' do
        result = dummy_class.char_represents_white_piece?(char_black_king)
        expect(result).to be(false)
      end
    end
  end

  describe '#char_represents_black_piece?' do
    context 'when parsing a character that represents a black piece' do
      subject(:char_black_queen) { 'q' }

      it 'returns true' do
        result = dummy_class.char_represents_black_piece?(char_black_queen)
        expect(result).to be(true)
      end
    end

    context 'when parsing a character that does not represent a black piece' do
      subject(:char_white_queen) { 'Q' }

      it 'returns false' do
        result = dummy_class.char_represents_black_piece?(char_white_queen)
        expect(result).to be(false)
      end
    end
  end

  describe '#char_represents_contiguous_empty_squares?' do
    context 'when parsing a character that represents eight contiguous empty squares' do
      subject(:char_eight) { '8' }

      it 'returns true' do
        result = dummy_class.char_represents_contiguous_empty_squares?(char_eight)
        expect(result).to be(true)
      end
    end

    context 'when parsing a character that represents one contiguous empty square' do
      subject(:char_one) { '1' }

      it 'returns true' do
        result = dummy_class.char_represents_contiguous_empty_squares?(char_one)
        expect(result).to be(true)
      end
    end

    context 'when parsing a character that does not represent contiguous empty squares' do
      subject(:char_white_king) { 'K' }

      it 'returns false' do
        result = dummy_class.char_represents_contiguous_empty_squares?(char_white_king)
        expect(result).to be(false)
      end
    end
  end
end
