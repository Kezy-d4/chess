# frozen_string_literal: true

describe Chess::Board do
  describe '::from_fen_parser' do
    context 'when passed a FENParser with the default FEN record' do
      subject { described_class }

      let(:default_fen) { Chess::ChessConstants::DEFAULT_FEN }
      let(:fen_parser_default) { Chess::FENParser.new(default_fen) }
      let(:expected) do
        <<~HEREDOC

          Rank 8:
          a8:
          The Square is occupied by a Rook.
            The Rook is black and has not moved.
          b8:
          The Square is occupied by a Knight.
            The Knight is black and has not moved.
          c8:
          The Square is occupied by a Bishop.
            The Bishop is black and has not moved.
          d8:
          The Square is occupied by a Queen.
            The Queen is black and has not moved.
          e8:
          The Square is occupied by a King.
            The King is black and has not moved.
          f8:
          The Square is occupied by a Bishop.
            The Bishop is black and has not moved.
          g8:
          The Square is occupied by a Knight.
            The Knight is black and has not moved.
          h8:
          The Square is occupied by a Rook.
            The Rook is black and has not moved.

          Rank 7:
          a7:
          The Square is occupied by a Pawn.
            The Pawn is black and has not moved.
          b7:
          The Square is occupied by a Pawn.
            The Pawn is black and has not moved.
          c7:
          The Square is occupied by a Pawn.
            The Pawn is black and has not moved.
          d7:
          The Square is occupied by a Pawn.
            The Pawn is black and has not moved.
          e7:
          The Square is occupied by a Pawn.
            The Pawn is black and has not moved.
          f7:
          The Square is occupied by a Pawn.
            The Pawn is black and has not moved.
          g7:
          The Square is occupied by a Pawn.
            The Pawn is black and has not moved.
          h7:
          The Square is occupied by a Pawn.
            The Pawn is black and has not moved.

          Rank 6:
          a6:
          The Square is unoccupied.
          b6:
          The Square is unoccupied.
          c6:
          The Square is unoccupied.
          d6:
          The Square is unoccupied.
          e6:
          The Square is unoccupied.
          f6:
          The Square is unoccupied.
          g6:
          The Square is unoccupied.
          h6:
          The Square is unoccupied.

          Rank 5:
          a5:
          The Square is unoccupied.
          b5:
          The Square is unoccupied.
          c5:
          The Square is unoccupied.
          d5:
          The Square is unoccupied.
          e5:
          The Square is unoccupied.
          f5:
          The Square is unoccupied.
          g5:
          The Square is unoccupied.
          h5:
          The Square is unoccupied.

          Rank 4:
          a4:
          The Square is unoccupied.
          b4:
          The Square is unoccupied.
          c4:
          The Square is unoccupied.
          d4:
          The Square is unoccupied.
          e4:
          The Square is unoccupied.
          f4:
          The Square is unoccupied.
          g4:
          The Square is unoccupied.
          h4:
          The Square is unoccupied.

          Rank 3:
          a3:
          The Square is unoccupied.
          b3:
          The Square is unoccupied.
          c3:
          The Square is unoccupied.
          d3:
          The Square is unoccupied.
          e3:
          The Square is unoccupied.
          f3:
          The Square is unoccupied.
          g3:
          The Square is unoccupied.
          h3:
          The Square is unoccupied.

          Rank 2:
          a2:
          The Square is occupied by a Pawn.
            The Pawn is white and has not moved.
          b2:
          The Square is occupied by a Pawn.
            The Pawn is white and has not moved.
          c2:
          The Square is occupied by a Pawn.
            The Pawn is white and has not moved.
          d2:
          The Square is occupied by a Pawn.
            The Pawn is white and has not moved.
          e2:
          The Square is occupied by a Pawn.
            The Pawn is white and has not moved.
          f2:
          The Square is occupied by a Pawn.
            The Pawn is white and has not moved.
          g2:
          The Square is occupied by a Pawn.
            The Pawn is white and has not moved.
          h2:
          The Square is occupied by a Pawn.
            The Pawn is white and has not moved.

          Rank 1:
          a1:
          The Square is occupied by a Rook.
            The Rook is white and has not moved.
          b1:
          The Square is occupied by a Knight.
            The Knight is white and has not moved.
          c1:
          The Square is occupied by a Bishop.
            The Bishop is white and has not moved.
          d1:
          The Square is occupied by a Queen.
            The Queen is white and has not moved.
          e1:
          The Square is occupied by a King.
            The King is white and has not moved.
          f1:
          The Square is occupied by a Bishop.
            The Bishop is white and has not moved.
          g1:
          The Square is occupied by a Knight.
            The Knight is white and has not moved.
          h1:
          The Square is occupied by a Rook.
            The Rook is white and has not moved.
        HEREDOC
      end

      it 'returns a Board with the expected state' do
        result = described_class.from_fen_parser(fen_parser_default)
        string = result.to_s
        expect(string).to eq(expected)
      end
    end
  end

  describe '#to_partial_fen' do
    context 'when testing with the starting board layout' do
      subject(:board_start) { described_class.from_fen_parser(fen_parser_default) }

      let(:default_fen) { Chess::ChessConstants::DEFAULT_FEN }
      let(:fen_parser_default) { Chess::FENParser.new(default_fen) }

      it 'returns a partial FEN record based on the data' do
        result = board_start.to_partial_fen
        expect(result).to eq('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR')
      end
    end

    context 'when testing with an endgame board layout' do
      subject(:board_endgame) { described_class.from_fen_parser(fen_parser_endgame) }

      let(:endgame_fen) { 'kq6/8/8/8/8/8/7P/7K w - - 0 65' }
      let(:fen_parser_endgame) { Chess::FENParser.new(endgame_fen) }

      it 'returns a partial FEN record based on the data' do
        result = board_endgame.to_partial_fen
        expect(result).to eq('kq6/8/8/8/8/8/7P/7K')
      end
    end
  end

  describe '#access_association' do
    subject(:board_start) { described_class.from_fen_parser(fen_parser_default) }

    let(:default_fen) { Chess::ChessConstants::DEFAULT_FEN }
    let(:fen_parser_default) { Chess::FENParser.new(default_fen) }
    let(:expected) do
      [
        'e8',
        "The Square is occupied by a King.\n\s\sThe King is black and has not moved."
      ]
    end

    it 'returns the association located at the given coordinates' do
      result = board_start.access_association('e8')
      strings = result.map(&:to_s)
      expect(strings).to eq(expected)
    end
  end

  describe '#collect_white_occupied_associations' do
    subject(:board_start) { described_class.from_fen_parser(fen_parser_default) }

    let(:default_fen) { Chess::ChessConstants::DEFAULT_FEN }
    let(:fen_parser_default) { Chess::FENParser.new(default_fen) }
    let(:expected) do
      [
        [
          'a2',
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved."
        ],
        [
          'b2',
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved."
        ],
        [
          'c2',
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved."
        ],
        [
          'd2',
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved."
        ],
        [
          'e2',
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved."
        ],
        [
          'f2',
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved."
        ],
        [
          'g2',
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved."
        ],
        [
          'h2',
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved."
        ],
        [
          'a1',
          "The Square is occupied by a Rook.\n\s\sThe Rook is white and has not moved."
        ],
        [
          'b1',
          "The Square is occupied by a Knight.\n\s\sThe Knight is white and has not moved."
        ],
        [
          'c1',
          "The Square is occupied by a Bishop.\n\s\sThe Bishop is white and has not moved."
        ],
        [
          'd1',
          "The Square is occupied by a Queen.\n\s\sThe Queen is white and has not moved."
        ],
        [
          'e1',
          "The Square is occupied by a King.\n\s\sThe King is white and has not moved."
        ],
        [
          'f1',
          "The Square is occupied by a Bishop.\n\s\sThe Bishop is white and has not moved."
        ],
        [
          'g1',
          "The Square is occupied by a Knight.\n\s\sThe Knight is white and has not moved."
        ],
        [
          'h1',
          "The Square is occupied by a Rook.\n\s\sThe Rook is white and has not moved."
        ]
      ]
    end

    it 'returns an array of white-occupied associations' do
      result = board_start.collect_white_occupied_associations
      strings = result.map { |association| association.map(&:to_s) }
      expect(strings).to match_array(expected)
    end
  end

  describe '#collect_black_occupied_associations' do
    subject(:board_start) { described_class.from_fen_parser(fen_parser_default) }

    let(:default_fen) { Chess::ChessConstants::DEFAULT_FEN }
    let(:fen_parser_default) { Chess::FENParser.new(default_fen) }
    let(:expected) do
      [
        [
          'a7',
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved."
        ],
        [
          'b7',
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved."
        ],
        [
          'c7',
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved."
        ],
        [
          'd7',
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved."
        ],
        [
          'e7',
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved."
        ],
        [
          'f7',
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved."
        ],
        [
          'g7',
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved."
        ],
        [
          'h7',
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved."
        ],
        [
          'a8',
          "The Square is occupied by a Rook.\n\s\sThe Rook is black and has not moved."
        ],
        [
          'b8',
          "The Square is occupied by a Knight.\n\s\sThe Knight is black and has not moved."
        ],
        [
          'c8',
          "The Square is occupied by a Bishop.\n\s\sThe Bishop is black and has not moved."
        ],
        [
          'd8',
          "The Square is occupied by a Queen.\n\s\sThe Queen is black and has not moved."
        ],
        [
          'e8',
          "The Square is occupied by a King.\n\s\sThe King is black and has not moved."
        ],
        [
          'f8',
          "The Square is occupied by a Bishop.\n\s\sThe Bishop is black and has not moved."
        ],
        [
          'g8',
          "The Square is occupied by a Knight.\n\s\sThe Knight is black and has not moved."
        ],
        [
          'h8',
          "The Square is occupied by a Rook.\n\s\sThe Rook is black and has not moved."
        ]
      ]
    end

    it 'returns an array of black-occupied associations' do
      result = board_start.collect_black_occupied_associations
      strings = result.map { |association| association.map(&:to_s) }
      expect(strings).to match_array(expected)
    end
  end
end
