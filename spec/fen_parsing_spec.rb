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

  describe '#char_represents_white_piece?' do
    context 'when testing a character that represents a white piece' do
      subject(:char_white_king) { 'K' }

      it 'returns true' do
        result = dummy_class.char_represents_white_piece?(char_white_king)
        expect(result).to be(true)
      end
    end

    context 'when testing a character that does not represent a white piece' do
      subject(:char_black_king) { 'k' }

      it 'returns false' do
        result = dummy_class.char_represents_white_piece?(char_black_king)
        expect(result).to be(false)
      end
    end
  end

  describe '#char_represents_black_piece?' do
    context 'when testing a character that represents a black piece' do
      subject(:char_black_queen) { 'q' }

      it 'returns true' do
        result = dummy_class.char_represents_black_piece?(char_black_queen)
        expect(result).to be(true)
      end
    end

    context 'when testing a character that does not represent a black piece' do
      subject(:char_white_queen) { 'Q' }

      it 'returns false' do
        result = dummy_class.char_represents_black_piece?(char_white_queen)
        expect(result).to be(false)
      end
    end
  end

  describe '#char_represents_contiguous_empty_squares?' do
    context 'when testing a character that represents eight contiguous empty squares' do
      subject(:char_eight) { '8' }

      it 'returns true' do
        result = dummy_class.char_represents_contiguous_empty_squares?(char_eight)
        expect(result).to be(true)
      end
    end

    context 'when testing a character that represents one contiguous empty square' do
      subject(:char_one) { '1' }

      it 'returns true' do
        result = dummy_class.char_represents_contiguous_empty_squares?(char_one)
        expect(result).to be(true)
      end
    end

    context 'when testing a character that does not represent contiguous empty squares' do
      subject(:char_white_king) { 'K' }

      it 'returns false' do
        result = dummy_class.char_represents_contiguous_empty_squares?(char_white_king)
        expect(result).to be(false)
      end
    end
  end
end
