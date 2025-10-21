# frozen_string_literal: true

require_relative '../lib/fen_parser'

describe FenParser do
  let(:dummy_class) { Class.new { extend FenParser } }

  describe '#construct_piece' do
    context 'when passed a character that represents a white king' do
      subject(:char_white_king) { 'K' }

      it 'returns a king' do
        result = dummy_class.construct_piece(char_white_king)
        expect(result).to be_a(King)
      end

      it 'assigns the king a white color' do
        result = dummy_class.construct_piece(char_white_king)
        expect(result.color).to eq(:white)
      end
    end

    context 'when passed a character that represents a black queen' do
      subject(:char_black_queen) { 'q' }

      it 'returns a queen' do
        result = dummy_class.construct_piece(char_black_queen)
        expect(result).to be_a(Queen)
      end

      it 'assigns the queen a black color' do
        result = dummy_class.construct_piece(char_black_queen)
        expect(result.color).to eq(:black)
      end
    end
  end

  describe '#construct_squares' do
    context 'when passed a simple endgame fen record' do
      subject(:fen_simple_endgame) { 'k7/8/8/8/8/8/6P1/7K w - - 0 65' }

      it 'returns an array' do
        result = dummy_class.construct_squares(fen_simple_endgame)
        expect(result).to be_an(Array)
      end

      it 'the array has a length of sixty-four' do
        result = dummy_class.construct_squares(fen_simple_endgame)
        expected_length =
          ChessConstants::AMOUNT_OF_BOARD_RANKS * ChessConstants::AMOUNT_OF_BOARD_FILES
        expect(result.length).to eq(expected_length)
      end

      it 'the array is composed entirely of square objects' do
        result = dummy_class.construct_squares(fen_simple_endgame)
        expect(result).to all be_a(Square)
      end

      it 'the square at index zero contains a king object' do
        result = dummy_class.construct_squares(fen_simple_endgame)
        expect(result[0].occupant).to be_a(King)
      end

      it 'the king at index zero has a black color' do
        result = dummy_class.construct_squares(fen_simple_endgame)
        expect(result[0].occupant.color).to eq(:black)
      end

      it 'the square at index fifty-four contains a pawn object' do
        result = dummy_class.construct_squares(fen_simple_endgame)
        expect(result[54].occupant).to be_a(Pawn)
      end

      it 'the pawn at index fifty-four has a white color' do
        result = dummy_class.construct_squares(fen_simple_endgame)
        expect(result[54].occupant.color).to eq(:white)
      end

      it 'the square at index sixty-three contains a king object' do
        result = dummy_class.construct_squares(fen_simple_endgame)
        expect(result[63].occupant).to be_a(King)
      end

      it 'the king at index sixty-three has a white color' do
        result = dummy_class.construct_squares(fen_simple_endgame)
        expect(result[63].occupant.color).to eq(:white)
      end

      it 'the squares at index one through fifty-three are all empty' do
        result = dummy_class.construct_squares(fen_simple_endgame)
        occupants = result[1..53].map(&:occupant)
        expect(occupants).to all be_nil
      end

      it 'the squares at index fifty-five through sixty-two are all empty' do
        result = dummy_class.construct_squares(fen_simple_endgame)
        occupants = result[55..62].map(&:occupant)
        expect(occupants).to all be_nil
      end
    end
  end

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

      it 'stores a substring of the active color data field' do
        result = dummy_class.parse_fen_record(fen_default)[:active_color_data]
        expected = 'w'
        expect(result).to eq(expected)
      end

      it 'stores a substring of the castling availability data field' do
        result = dummy_class.parse_fen_record(fen_default)[:castling_availability_data]
        expected = 'KQkq'
        expect(result).to eq(expected)
      end

      it 'stores a substring of the en passant target square data field' do
        result = dummy_class.parse_fen_record(fen_default)[:en_passant_target_square_data]
        expected = '-'
        expect(result).to eq(expected)
      end

      it 'stores a substring of the half move clock data field' do
        result = dummy_class.parse_fen_record(fen_default)[:half_move_clock_data]
        expected = '0'
        expect(result).to eq(expected)
      end

      it 'stores a substring of the full move number data field' do
        result = dummy_class.parse_fen_record(fen_default)[:full_move_number_data]
        expected = '1'
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
