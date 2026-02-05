# frozen_string_literal: true

describe Chess::Pieces do
  let(:dummy_class) { Class.new { extend Chess::Pieces } }

  describe '#construct_piece_from_char' do
    subject { dummy_class }

    context 'when passed the character representing a white King' do
      let(:char_white_king) { 'K' }

      it 'returns a King' do
        result = dummy_class.construct_piece_from_char(char_white_king)
        expect(result).to be_a(Chess::King)
      end

      it 'returns a King with a white color' do
        result = dummy_class.construct_piece_from_char(char_white_king)
        color = result.instance_variable_get(:@color)
        expect(color).to eq(:white)
      end

      it 'returns a King with zero total moves' do
        result = dummy_class.construct_piece_from_char(char_white_king)
        total_moves = result.instance_variable_get(:@total_moves)
        expect(total_moves).to eq(0)
      end
    end

    context 'when passed the character representing a black King' do
      let(:char_black_king) { 'k' }

      it 'returns a King' do
        result = dummy_class.construct_piece_from_char(char_black_king)
        expect(result).to be_a(Chess::King)
      end

      it 'returns a King with a black color' do
        result = dummy_class.construct_piece_from_char(char_black_king)
        color = result.instance_variable_get(:@color)
        expect(color).to eq(:black)
      end

      it 'returns a King with zero total moves' do
        result = dummy_class.construct_piece_from_char(char_black_king)
        total_moves = result.instance_variable_get(:@total_moves)
        expect(total_moves).to eq(0)
      end
    end

    context 'when passed the character representing a white Queen' do
      let(:char_white_queen) { 'Q' }

      it 'returns a Queen' do
        result = dummy_class.construct_piece_from_char(char_white_queen)
        expect(result).to be_a(Chess::Queen)
      end

      it 'returns a Queen with a white color' do
        result = dummy_class.construct_piece_from_char(char_white_queen)
        color = result.instance_variable_get(:@color)
        expect(color).to eq(:white)
      end

      it 'returns a Queen with zero total moves' do
        result = dummy_class.construct_piece_from_char(char_white_queen)
        total_moves = result.instance_variable_get(:@total_moves)
        expect(total_moves).to eq(0)
      end
    end

    context 'when passed the character representing a black Queen' do
      let(:char_black_queen) { 'q' }

      it 'returns a Queen' do
        result = dummy_class.construct_piece_from_char(char_black_queen)
        expect(result).to be_a(Chess::Queen)
      end

      it 'returns a Queen with a black color' do
        result = dummy_class.construct_piece_from_char(char_black_queen)
        color = result.instance_variable_get(:@color)
        expect(color).to eq(:black)
      end

      it 'returns a Queen with zero total moves' do
        result = dummy_class.construct_piece_from_char(char_black_queen)
        total_moves = result.instance_variable_get(:@total_moves)
        expect(total_moves).to eq(0)
      end
    end

    context 'when passed the character representing a white Rook' do
      let(:char_white_rook) { 'R' }

      it 'returns a Rook' do
        result = dummy_class.construct_piece_from_char(char_white_rook)
        expect(result).to be_a(Chess::Rook)
      end

      it 'returns a Rook with a white color' do
        result = dummy_class.construct_piece_from_char(char_white_rook)
        color = result.instance_variable_get(:@color)
        expect(color).to eq(:white)
      end

      it 'returns a Rook with zero total moves' do
        result = dummy_class.construct_piece_from_char(char_white_rook)
        total_moves = result.instance_variable_get(:@total_moves)
        expect(total_moves).to eq(0)
      end
    end

    context 'when passed the character representing a black Rook' do
      let(:char_black_rook) { 'r' }

      it 'returns a Rook' do
        result = dummy_class.construct_piece_from_char(char_black_rook)
        expect(result).to be_a(Chess::Rook)
      end

      it 'returns a Rook with a black color' do
        result = dummy_class.construct_piece_from_char(char_black_rook)
        color = result.instance_variable_get(:@color)
        expect(color).to eq(:black)
      end

      it 'returns a Rook with zero total moves' do
        result = dummy_class.construct_piece_from_char(char_black_rook)
        total_moves = result.instance_variable_get(:@total_moves)
        expect(total_moves).to eq(0)
      end
    end

    context 'when passed the character representing a white Bishop' do
      let(:char_white_bishop) { 'B' }

      it 'returns a Bishop' do
        result = dummy_class.construct_piece_from_char(char_white_bishop)
        expect(result).to be_a(Chess::Bishop)
      end

      it 'returns a Bishop with a white color' do
        result = dummy_class.construct_piece_from_char(char_white_bishop)
        color = result.instance_variable_get(:@color)
        expect(color).to eq(:white)
      end

      it 'returns a Bishop with zero total moves' do
        result = dummy_class.construct_piece_from_char(char_white_bishop)
        total_moves = result.instance_variable_get(:@total_moves)
        expect(total_moves).to eq(0)
      end
    end

    context 'when passed the character representing a black Bishop' do
      let(:char_black_bishop) { 'b' }

      it 'returns a Bishop' do
        result = dummy_class.construct_piece_from_char(char_black_bishop)
        expect(result).to be_a(Chess::Bishop)
      end

      it 'returns a Bishop with a black color' do
        result = dummy_class.construct_piece_from_char(char_black_bishop)
        color = result.instance_variable_get(:@color)
        expect(color).to eq(:black)
      end

      it 'returns a Bishop with zero total moves' do
        result = dummy_class.construct_piece_from_char(char_black_bishop)
        total_moves = result.instance_variable_get(:@total_moves)
        expect(total_moves).to eq(0)
      end
    end

    context 'when passed the character representing a white Knight' do
      let(:char_white_knight) { 'N' }

      it 'returns a Knight' do
        result = dummy_class.construct_piece_from_char(char_white_knight)
        expect(result).to be_a(Chess::Knight)
      end

      it 'returns a Knight with a white color' do
        result = dummy_class.construct_piece_from_char(char_white_knight)
        color = result.instance_variable_get(:@color)
        expect(color).to eq(:white)
      end

      it 'returns a Knight with zero total moves' do
        result = dummy_class.construct_piece_from_char(char_white_knight)
        total_moves = result.instance_variable_get(:@total_moves)
        expect(total_moves).to eq(0)
      end
    end

    context 'when passed the character representing a black Knight' do
      let(:char_black_knight) { 'n' }

      it 'returns a Knight' do
        result = dummy_class.construct_piece_from_char(char_black_knight)
        expect(result).to be_a(Chess::Knight)
      end

      it 'returns a Knight with a black color' do
        result = dummy_class.construct_piece_from_char(char_black_knight)
        color = result.instance_variable_get(:@color)
        expect(color).to eq(:black)
      end

      it 'returns a Knight with zero total moves' do
        result = dummy_class.construct_piece_from_char(char_black_knight)
        total_moves = result.instance_variable_get(:@total_moves)
        expect(total_moves).to eq(0)
      end
    end

    context 'when passed the character representing a white Pawn' do
      let(:char_white_pawn) { 'P' }

      it 'returns a Pawn' do
        result = dummy_class.construct_piece_from_char(char_white_pawn)
        expect(result).to be_a(Chess::Pawn)
      end

      it 'returns a Pawn with a white color' do
        result = dummy_class.construct_piece_from_char(char_white_pawn)
        color = result.instance_variable_get(:@color)
        expect(color).to eq(:white)
      end

      it 'returns a Pawn with zero total moves' do
        result = dummy_class.construct_piece_from_char(char_white_pawn)
        total_moves = result.instance_variable_get(:@total_moves)
        expect(total_moves).to eq(0)
      end
    end

    context 'when passed the character representing a black Pawn' do
      let(:char_black_pawn) { 'p' }

      it 'returns a Pawn' do
        result = dummy_class.construct_piece_from_char(char_black_pawn)
        expect(result).to be_a(Chess::Pawn)
      end

      it 'returns a Pawn with a black color' do
        result = dummy_class.construct_piece_from_char(char_black_pawn)
        color = result.instance_variable_get(:@color)
        expect(color).to eq(:black)
      end

      it 'returns a Pawn with zero total moves' do
        result = dummy_class.construct_piece_from_char(char_black_pawn)
        total_moves = result.instance_variable_get(:@total_moves)
        expect(total_moves).to eq(0)
      end
    end
  end

  describe '#convert_piece_to_char' do
    subject { dummy_class }

    context 'when passed a King with a white color' do
      it 'returns the character representing a white King' do
        king_white = double('King', white?: true, black?: false, class: Chess::King)
        result = dummy_class.convert_piece_to_char(king_white)
        expect(result).to eq('K')
      end
    end

    context 'when passed a King with a black color' do
      it 'returns the character representing a black King' do
        king_black = double('King', white?: false, black?: true, class: Chess::King)
        result = dummy_class.convert_piece_to_char(king_black)
        expect(result).to eq('k')
      end
    end

    context 'when passed a Queen with a white color' do
      it 'returns the character representing a white Queen' do
        queen_white = double('Queen', white?: true, black?: false, class: Chess::Queen)
        result = dummy_class.convert_piece_to_char(queen_white)
        expect(result).to eq('Q')
      end
    end

    context 'when passed a Queen with a black color' do
      it 'returns the character representing a black Queen' do
        queen_black = double('Queen', white?: false, black?: true, class: Chess::Queen)
        result = dummy_class.convert_piece_to_char(queen_black)
        expect(result).to eq('q')
      end
    end

    context 'when passed a Rook with a white color' do
      it 'returns the character representing a white Rook' do
        rook_white = double('Rook', white?: true, black?: false, class: Chess::Rook)
        result = dummy_class.convert_piece_to_char(rook_white)
        expect(result).to eq('R')
      end
    end

    context 'when passed a Rook with a black color' do
      it 'returns the character representing a black Rook' do
        rook_black = double('Rook', white?: false, black?: true, class: Chess::Rook)
        result = dummy_class.convert_piece_to_char(rook_black)
        expect(result).to eq('r')
      end
    end

    context 'when passed a Bishop with a white color' do
      it 'returns the character representing a white Bishop' do
        bishop_white = double('Bishop', white?: true, black?: false, class: Chess::Bishop)
        result = dummy_class.convert_piece_to_char(bishop_white)
        expect(result).to eq('B')
      end
    end

    context 'when passed a Bishop with a black color' do
      it 'returns the character representing a black Bishop' do
        bishop_black = double('Bishop', white?: false, black?: true, class: Chess::Bishop)
        result = dummy_class.convert_piece_to_char(bishop_black)
        expect(result).to eq('b')
      end
    end

    context 'when passed a Knight with a white color' do
      it 'returns the character representing a white Knight' do
        knight_white = double('Knight', white?: true, black?: false, class: Chess::Knight)
        result = dummy_class.convert_piece_to_char(knight_white)
        expect(result).to eq('N')
      end
    end

    context 'when passed a Knight with a black color' do
      it 'returns the character representing a black Knight' do
        knight_black = double('Knight', white?: false, black?: true, class: Chess::Knight)
        result = dummy_class.convert_piece_to_char(knight_black)
        expect(result).to eq('n')
      end
    end

    context 'when passed a Pawn with a white color' do
      it 'returns the character representing a white Pawn' do
        pawn_white = double('Pawn', white?: true, black?: false, class: Chess::Pawn)
        result = dummy_class.convert_piece_to_char(pawn_white)
        expect(result).to eq('P')
      end
    end

    context 'when passed a Pawn with a black color' do
      it 'returns the character representing a black Pawn' do
        pawn_black = double('Pawn', white?: false, black?: true, class: Chess::Pawn)
        result = dummy_class.convert_piece_to_char(pawn_black)
        expect(result).to eq('p')
      end
    end
  end
end
