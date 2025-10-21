# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  let(:expected_algebraic_coords) do
    %w[a8 b8 c8 d8 e8 f8 g8 h8
       a7 b7 c7 d7 e7 f7 g7 h7
       a6 b6 c6 d6 e6 f6 g6 h6
       a5 b5 c5 d5 e5 f5 g5 h5
       a4 b4 c4 d4 e4 f4 g4 h4
       a3 b3 c3 d3 e3 f3 g3 h3
       a2 b2 c2 d2 e2 f2 g2 h2
       a1 b1 c1 d1 e1 f1 g1 h1]
  end

  describe '#generate_algebraic_coords' do
    it 'returns an array of algebraic coords as strings in standard fen order' do
      result = described_class.generate_algebraic_coords
      expect(result).to eq(expected_algebraic_coords)
    end
  end

  describe '#from_fen' do
    context 'when passed a simple endgame fen record' do
      subject(:fen_simple_endgame) { 'k7/8/8/8/8/8/8/7K w - - 0 65' }

      it 'returns a board' do
        result = described_class.from_fen(fen_simple_endgame)
        expect(result).to be_a(described_class)
      end

      it 'stores the board\'s squares in a hash' do
        result = described_class.from_fen(fen_simple_endgame)
        squares = result.instance_variable_get(:@squares)
        expect(squares).to be_a(Hash)
      end

      it 'labels each square with the expected algebraic coordinates' do
        result = described_class.from_fen(fen_simple_endgame)
        squares = result.instance_variable_get(:@squares)
        expect(squares.keys).to eq(expected_algebraic_coords)
      end

      it 'the square at coordinates a8 contains a king object' do
        result = described_class.from_fen(fen_simple_endgame)
        squares = result.instance_variable_get(:@squares)
        expect(squares['a8'].occupant).to be_a(King)
      end

      it 'the king at coordinates a8 has a black color' do
        result = described_class.from_fen(fen_simple_endgame)
        squares = result.instance_variable_get(:@squares)
        expect(squares['a8'].occupant.color).to eq(:black)
      end

      it 'the square at coordinates h1 contains a king object' do
        result = described_class.from_fen(fen_simple_endgame)
        squares = result.instance_variable_get(:@squares)
        expect(squares['h1'].occupant).to be_a(King)
      end

      it 'the king at coordinates h1 has a white color' do
        result = described_class.from_fen(fen_simple_endgame)
        squares = result.instance_variable_get(:@squares)
        expect(squares['h1'].occupant.color).to eq(:white)
      end

      it 'the squares at coordinates b8 through g1 are all empty' do
        result = described_class.from_fen(fen_simple_endgame)
        squares = result.instance_variable_get(:@squares)
        squares = squares.except('a8', 'h1')
        occupants = squares.values.map(&:occupant)
        expect(occupants).to all be_nil
      end
    end
  end

  describe '#access_square' do
    context 'when constructed from the default fen record and passed coordinates e8' do
      subject(:board_default) { described_class.from_fen(ChessConstants::DEFAULT_FEN) }

      let(:algebraic_e8) { 'e8' }

      it 'returns a square object' do
        result = board_default.access_square(algebraic_e8)
        expect(result).to be_a(Square)
      end

      it 'the square contains a king object' do
        result = board_default.access_square(algebraic_e8)
        expect(result.occupant).to be_a(King)
      end

      it 'the king has a black color' do
        result = board_default.access_square(algebraic_e8)
        expect(result.occupant.color).to eq(:black)
      end
    end

    context 'when constructed from the default fen record and passed coordinates a6' do
      subject(:board_default) { described_class.from_fen(ChessConstants::DEFAULT_FEN) }

      let(:algebraic_a6) { 'a6' }

      it 'returns a square object' do
        result = board_default.access_square(algebraic_a6)
        expect(result).to be_a(Square)
      end

      it 'the square is empty' do
        result = board_default.access_square(algebraic_a6)
        expect(result.occupant).to be_nil
      end
    end
  end
end
