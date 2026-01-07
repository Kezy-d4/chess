# frozen_string_literal: true

describe Chess::Board do
  describe '::from_fen_parser' do
    subject { described_class }

    context 'when passed a FENParser with the default FEN record' do
      let(:fen_parser_default) { Chess::FENParser.new(Chess::ChessConstants::DEFAULT_FEN) }
      let(:expected) do
        <<~HEREDOC

          Rank 8:
          The Square at coordinates a8 is occupied by a Rook.
            The Rook is black and has not moved.
          The Square at coordinates b8 is occupied by a Knight.
            The Knight is black and has not moved.
          The Square at coordinates c8 is occupied by a Bishop.
            The Bishop is black and has not moved.
          The Square at coordinates d8 is occupied by a Queen.
            The Queen is black and has not moved.
          The Square at coordinates e8 is occupied by a King.
            The King is black and has not moved.
          The Square at coordinates f8 is occupied by a Bishop.
            The Bishop is black and has not moved.
          The Square at coordinates g8 is occupied by a Knight.
            The Knight is black and has not moved.
          The Square at coordinates h8 is occupied by a Rook.
            The Rook is black and has not moved.

          Rank 7:
          The Square at coordinates a7 is occupied by a Pawn.
            The Pawn is black and has not moved.
          The Square at coordinates b7 is occupied by a Pawn.
            The Pawn is black and has not moved.
          The Square at coordinates c7 is occupied by a Pawn.
            The Pawn is black and has not moved.
          The Square at coordinates d7 is occupied by a Pawn.
            The Pawn is black and has not moved.
          The Square at coordinates e7 is occupied by a Pawn.
            The Pawn is black and has not moved.
          The Square at coordinates f7 is occupied by a Pawn.
            The Pawn is black and has not moved.
          The Square at coordinates g7 is occupied by a Pawn.
            The Pawn is black and has not moved.
          The Square at coordinates h7 is occupied by a Pawn.
            The Pawn is black and has not moved.

          Rank 6:
          The Square at coordinates a6 is unoccupied.
          The Square at coordinates b6 is unoccupied.
          The Square at coordinates c6 is unoccupied.
          The Square at coordinates d6 is unoccupied.
          The Square at coordinates e6 is unoccupied.
          The Square at coordinates f6 is unoccupied.
          The Square at coordinates g6 is unoccupied.
          The Square at coordinates h6 is unoccupied.

          Rank 5:
          The Square at coordinates a5 is unoccupied.
          The Square at coordinates b5 is unoccupied.
          The Square at coordinates c5 is unoccupied.
          The Square at coordinates d5 is unoccupied.
          The Square at coordinates e5 is unoccupied.
          The Square at coordinates f5 is unoccupied.
          The Square at coordinates g5 is unoccupied.
          The Square at coordinates h5 is unoccupied.

          Rank 4:
          The Square at coordinates a4 is unoccupied.
          The Square at coordinates b4 is unoccupied.
          The Square at coordinates c4 is unoccupied.
          The Square at coordinates d4 is unoccupied.
          The Square at coordinates e4 is unoccupied.
          The Square at coordinates f4 is unoccupied.
          The Square at coordinates g4 is unoccupied.
          The Square at coordinates h4 is unoccupied.

          Rank 3:
          The Square at coordinates a3 is unoccupied.
          The Square at coordinates b3 is unoccupied.
          The Square at coordinates c3 is unoccupied.
          The Square at coordinates d3 is unoccupied.
          The Square at coordinates e3 is unoccupied.
          The Square at coordinates f3 is unoccupied.
          The Square at coordinates g3 is unoccupied.
          The Square at coordinates h3 is unoccupied.

          Rank 2:
          The Square at coordinates a2 is occupied by a Pawn.
            The Pawn is white and has not moved.
          The Square at coordinates b2 is occupied by a Pawn.
            The Pawn is white and has not moved.
          The Square at coordinates c2 is occupied by a Pawn.
            The Pawn is white and has not moved.
          The Square at coordinates d2 is occupied by a Pawn.
            The Pawn is white and has not moved.
          The Square at coordinates e2 is occupied by a Pawn.
            The Pawn is white and has not moved.
          The Square at coordinates f2 is occupied by a Pawn.
            The Pawn is white and has not moved.
          The Square at coordinates g2 is occupied by a Pawn.
            The Pawn is white and has not moved.
          The Square at coordinates h2 is occupied by a Pawn.
            The Pawn is white and has not moved.

          Rank 1:
          The Square at coordinates a1 is occupied by a Rook.
            The Rook is white and has not moved.
          The Square at coordinates b1 is occupied by a Knight.
            The Knight is white and has not moved.
          The Square at coordinates c1 is occupied by a Bishop.
            The Bishop is white and has not moved.
          The Square at coordinates d1 is occupied by a Queen.
            The Queen is white and has not moved.
          The Square at coordinates e1 is occupied by a King.
            The King is white and has not moved.
          The Square at coordinates f1 is occupied by a Bishop.
            The Bishop is white and has not moved.
          The Square at coordinates g1 is occupied by a Knight.
            The Knight is white and has not moved.
          The Square at coordinates h1 is occupied by a Rook.
            The Rook is white and has not moved.
        HEREDOC
      end

      it 'returns a Board with the expected state' do
        result = described_class.from_fen_parser(fen_parser_default)
        string = result.to_s
        expect(string).to eq(expected)
      end
    end

    context 'when passed a FENParser with a non-default FEN record' do
      let(:non_default_fen) { 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1' }
      let(:fen_parser_non_default) { Chess::FENParser.new(non_default_fen) }
      let(:expected) do
        <<~HEREDOC

          Rank 8:
          The Square at coordinates a8 is occupied by a Rook.
            The Rook is black and has not moved.
          The Square at coordinates b8 is occupied by a Knight.
            The Knight is black and has not moved.
          The Square at coordinates c8 is occupied by a Bishop.
            The Bishop is black and has not moved.
          The Square at coordinates d8 is occupied by a Queen.
            The Queen is black and has not moved.
          The Square at coordinates e8 is occupied by a King.
            The King is black and has not moved.
          The Square at coordinates f8 is occupied by a Bishop.
            The Bishop is black and has not moved.
          The Square at coordinates g8 is occupied by a Knight.
            The Knight is black and has not moved.
          The Square at coordinates h8 is occupied by a Rook.
            The Rook is black and has not moved.

          Rank 7:
          The Square at coordinates a7 is occupied by a Pawn.
            The Pawn is black and has not moved.
          The Square at coordinates b7 is occupied by a Pawn.
            The Pawn is black and has not moved.
          The Square at coordinates c7 is occupied by a Pawn.
            The Pawn is black and has not moved.
          The Square at coordinates d7 is occupied by a Pawn.
            The Pawn is black and has not moved.
          The Square at coordinates e7 is occupied by a Pawn.
            The Pawn is black and has not moved.
          The Square at coordinates f7 is occupied by a Pawn.
            The Pawn is black and has not moved.
          The Square at coordinates g7 is occupied by a Pawn.
            The Pawn is black and has not moved.
          The Square at coordinates h7 is occupied by a Pawn.
            The Pawn is black and has not moved.

          Rank 6:
          The Square at coordinates a6 is unoccupied.
          The Square at coordinates b6 is unoccupied.
          The Square at coordinates c6 is unoccupied.
          The Square at coordinates d6 is unoccupied.
          The Square at coordinates e6 is unoccupied.
          The Square at coordinates f6 is unoccupied.
          The Square at coordinates g6 is unoccupied.
          The Square at coordinates h6 is unoccupied.

          Rank 5:
          The Square at coordinates a5 is unoccupied.
          The Square at coordinates b5 is unoccupied.
          The Square at coordinates c5 is unoccupied.
          The Square at coordinates d5 is unoccupied.
          The Square at coordinates e5 is unoccupied.
          The Square at coordinates f5 is unoccupied.
          The Square at coordinates g5 is unoccupied.
          The Square at coordinates h5 is unoccupied.

          Rank 4:
          The Square at coordinates a4 is unoccupied.
          The Square at coordinates b4 is unoccupied.
          The Square at coordinates c4 is unoccupied.
          The Square at coordinates d4 is unoccupied.
          The Square at coordinates e4 is occupied by a Pawn.
            The Pawn is white and has not moved.
          The Square at coordinates f4 is unoccupied.
          The Square at coordinates g4 is unoccupied.
          The Square at coordinates h4 is unoccupied.

          Rank 3:
          The Square at coordinates a3 is unoccupied.
          The Square at coordinates b3 is unoccupied.
          The Square at coordinates c3 is unoccupied.
          The Square at coordinates d3 is unoccupied.
          The Square at coordinates e3 is unoccupied.
          The Square at coordinates f3 is unoccupied.
          The Square at coordinates g3 is unoccupied.
          The Square at coordinates h3 is unoccupied.

          Rank 2:
          The Square at coordinates a2 is occupied by a Pawn.
            The Pawn is white and has not moved.
          The Square at coordinates b2 is occupied by a Pawn.
            The Pawn is white and has not moved.
          The Square at coordinates c2 is occupied by a Pawn.
            The Pawn is white and has not moved.
          The Square at coordinates d2 is occupied by a Pawn.
            The Pawn is white and has not moved.
          The Square at coordinates e2 is unoccupied.
          The Square at coordinates f2 is occupied by a Pawn.
            The Pawn is white and has not moved.
          The Square at coordinates g2 is occupied by a Pawn.
            The Pawn is white and has not moved.
          The Square at coordinates h2 is occupied by a Pawn.
            The Pawn is white and has not moved.

          Rank 1:
          The Square at coordinates a1 is occupied by a Rook.
            The Rook is white and has not moved.
          The Square at coordinates b1 is occupied by a Knight.
            The Knight is white and has not moved.
          The Square at coordinates c1 is occupied by a Bishop.
            The Bishop is white and has not moved.
          The Square at coordinates d1 is occupied by a Queen.
            The Queen is white and has not moved.
          The Square at coordinates e1 is occupied by a King.
            The King is white and has not moved.
          The Square at coordinates f1 is occupied by a Bishop.
            The Bishop is white and has not moved.
          The Square at coordinates g1 is occupied by a Knight.
            The Knight is white and has not moved.
          The Square at coordinates h1 is occupied by a Rook.
            The Rook is white and has not moved.
        HEREDOC
      end

      it 'returns a Board with the expected state' do
        result = described_class.from_fen_parser(fen_parser_non_default)
        string = result.to_s
        expect(string).to eq(expected)
      end
    end
  end

  describe '#to_partial_fen' do
    context 'when the Board has the default state' do
      subject(:board_default) { described_class.from_fen_parser(fen_parser_default) }

      let(:fen_parser_default) { Chess::FENParser.new(Chess::ChessConstants::DEFAULT_FEN) }

      it 'returns a partial FEN record based on the data' do
        result = board_default.to_partial_fen
        expect(result).to eq('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR')
      end
    end

    context 'when the Board has non-default state' do
      subject(:board_non_default) { described_class.from_fen_parser(fen_parser_non_default) }

      let(:non_default_fen) { 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1' }
      let(:fen_parser_non_default) { Chess::FENParser.new(non_default_fen) }

      it 'returns a partial FEN record based on the data' do
        result = board_non_default.to_partial_fen
        expect(result).to eq('rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR')
      end
    end
  end

  describe '#access_square' do
    context 'when testing with a default Board and passed coordinates e8' do
      subject(:board_default) { described_class.from_fen_parser(fen_parser_default) }

      let(:fen_parser_default) { Chess::FENParser.new(Chess::ChessConstants::DEFAULT_FEN) }
      let(:expected) do
        "The Square at coordinates e8 is occupied by a King.\n" \
          "\s\sThe King is black and has not moved."
      end

      it 'returns the Square at coordinates e8' do
        result = board_default.access_square('e8')
        string = result.to_s
        expect(string).to eq(expected)
      end
    end

    context 'when testing with a default Board and passed coordinates e1' do
      subject(:board_default) { described_class.from_fen_parser(fen_parser_default) }

      let(:fen_parser_default) { Chess::FENParser.new(Chess::ChessConstants::DEFAULT_FEN) }
      let(:expected) do
        "The Square at coordinates e1 is occupied by a King.\n" \
          "\s\sThe King is white and has not moved."
      end

      it 'returns the Square at coordinates e1' do
        result = board_default.access_square('e1')
        string = result.to_s
        expect(string).to eq(expected)
      end
    end

    context 'when testing with a default Board and passed coordinates e4' do
      subject(:board_default) { described_class.from_fen_parser(fen_parser_default) }

      let(:fen_parser_default) { Chess::FENParser.new(Chess::ChessConstants::DEFAULT_FEN) }
      let(:expected) { 'The Square at coordinates e4 is unoccupied.' }

      it 'returns the Square at coordinates e4' do
        result = board_default.access_square('e4')
        string = result.to_s
        expect(string).to eq(expected)
      end
    end
  end

  describe '#collect_white_occupied_squares' do
    context 'when testing with a default Board' do
      subject(:board_default) { described_class.from_fen_parser(fen_parser_default) }

      let(:fen_parser_default) { Chess::FENParser.new(Chess::ChessConstants::DEFAULT_FEN) }
      let(:expected) do
        [
          "The Square at coordinates a2 is occupied by a Pawn.\n" \
          "\s\sThe Pawn is white and has not moved.",
          "The Square at coordinates b2 is occupied by a Pawn.\n" \
          "\s\sThe Pawn is white and has not moved.",
          "The Square at coordinates c2 is occupied by a Pawn.\n" \
          "\s\sThe Pawn is white and has not moved.",
          "The Square at coordinates d2 is occupied by a Pawn.\n" \
          "\s\sThe Pawn is white and has not moved.",
          "The Square at coordinates e2 is occupied by a Pawn.\n" \
          "\s\sThe Pawn is white and has not moved.",
          "The Square at coordinates f2 is occupied by a Pawn.\n" \
          "\s\sThe Pawn is white and has not moved.",
          "The Square at coordinates g2 is occupied by a Pawn.\n" \
          "\s\sThe Pawn is white and has not moved.",
          "The Square at coordinates h2 is occupied by a Pawn.\n" \
          "\s\sThe Pawn is white and has not moved.",
          "The Square at coordinates a1 is occupied by a Rook.\n" \
          "\s\sThe Rook is white and has not moved.",
          "The Square at coordinates b1 is occupied by a Knight.\n" \
          "\s\sThe Knight is white and has not moved.",
          "The Square at coordinates c1 is occupied by a Bishop.\n" \
          "\s\sThe Bishop is white and has not moved.",
          "The Square at coordinates d1 is occupied by a Queen.\n" \
          "\s\sThe Queen is white and has not moved.",
          "The Square at coordinates e1 is occupied by a King.\n" \
          "\s\sThe King is white and has not moved.",
          "The Square at coordinates f1 is occupied by a Bishop.\n" \
          "\s\sThe Bishop is white and has not moved.",
          "The Square at coordinates g1 is occupied by a Knight.\n" \
          "\s\sThe Knight is white and has not moved.",
          "The Square at coordinates h1 is occupied by a Rook.\n" \
          "\s\sThe Rook is white and has not moved."
        ]
      end

      it 'returns an array of all the white-occupied Squares on the Board' do
        result = board_default.collect_white_occupied_squares
        strings = result.map(&:to_s)
        expect(strings).to match_array(expected)
      end
    end
  end

  describe '#collect_black_occupied_squares' do
    context 'when testing with a default Board' do
      subject(:board_default) { described_class.from_fen_parser(fen_parser_default) }

      let(:fen_parser_default) { Chess::FENParser.new(Chess::ChessConstants::DEFAULT_FEN) }
      let(:expected) do
        [
          "The Square at coordinates a7 is occupied by a Pawn.\n" \
          "\s\sThe Pawn is black and has not moved.",
          "The Square at coordinates b7 is occupied by a Pawn.\n" \
          "\s\sThe Pawn is black and has not moved.",
          "The Square at coordinates c7 is occupied by a Pawn.\n" \
          "\s\sThe Pawn is black and has not moved.",
          "The Square at coordinates d7 is occupied by a Pawn.\n" \
          "\s\sThe Pawn is black and has not moved.",
          "The Square at coordinates e7 is occupied by a Pawn.\n" \
          "\s\sThe Pawn is black and has not moved.",
          "The Square at coordinates f7 is occupied by a Pawn.\n" \
          "\s\sThe Pawn is black and has not moved.",
          "The Square at coordinates g7 is occupied by a Pawn.\n" \
          "\s\sThe Pawn is black and has not moved.",
          "The Square at coordinates h7 is occupied by a Pawn.\n" \
          "\s\sThe Pawn is black and has not moved.",
          "The Square at coordinates a8 is occupied by a Rook.\n" \
          "\s\sThe Rook is black and has not moved.",
          "The Square at coordinates b8 is occupied by a Knight.\n" \
          "\s\sThe Knight is black and has not moved.",
          "The Square at coordinates c8 is occupied by a Bishop.\n" \
          "\s\sThe Bishop is black and has not moved.",
          "The Square at coordinates d8 is occupied by a Queen.\n" \
          "\s\sThe Queen is black and has not moved.",
          "The Square at coordinates e8 is occupied by a King.\n" \
          "\s\sThe King is black and has not moved.",
          "The Square at coordinates f8 is occupied by a Bishop.\n" \
          "\s\sThe Bishop is black and has not moved.",
          "The Square at coordinates g8 is occupied by a Knight.\n" \
          "\s\sThe Knight is black and has not moved.",
          "The Square at coordinates h8 is occupied by a Rook.\n" \
          "\s\sThe Rook is black and has not moved."
        ]
      end

      it 'returns an array of all the black-occupied Squares on the Board' do
        result = board_default.collect_black_occupied_squares
        strings = result.map(&:to_s)
        expect(strings).to match_array(expected)
      end
    end
  end
end
