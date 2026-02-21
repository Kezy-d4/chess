# frozen_string_literal: true

describe Chess::Board do
  describe '::from_fen_parser' do
    context 'when passed a FENParser with a default FEN record' do
      subject { described_class }

      let(:fen_default) { Chess::ChessConstants::FEN_DEFAULT }
      let(:fen_parser_default) { Chess::FENParser.new(fen_default) }
      let(:expected) do
        <<~HEREDOC
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
    context 'when testing with a default Board' do
      subject(:board_default) { described_class.from_fen_parser(fen_parser_default) }

      let(:fen_default) { Chess::ChessConstants::FEN_DEFAULT }
      let(:fen_parser_default) { Chess::FENParser.new(fen_default) }

      it 'returns a partial FEN record based on the data' do
        result = board_default.to_partial_fen
        expect(result).to eq('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR')
      end
    end

    context 'when testing with an endgame Board' do
      subject(:board_endgame) { described_class.from_fen_parser(fen_parser_endgame) }

      let(:fen_endgame) { 'kq6/8/8/8/8/8/7P/7K b - - 0 65' }
      let(:fen_parser_endgame) { Chess::FENParser.new(fen_endgame) }

      it 'returns a partial FEN record based on the data' do
        result = board_endgame.to_partial_fen
        expect(result).to eq('kq6/8/8/8/8/8/7P/7K')
      end
    end
  end

  describe '#assoc_at' do
    subject(:board_default) { described_class.from_fen_parser(fen_parser_default) }

    let(:fen_default) { Chess::ChessConstants::FEN_DEFAULT }
    let(:fen_parser_default) { Chess::FENParser.new(fen_default) }
    let(:expected) do
      [
        'e1',
        "The Square is occupied by a King.\n\s\sThe King is white and has not moved."
      ]
    end

    it 'returns the association located at the given coordinates' do
      coord_e1 = Chess::Coord.from_s('e1')
      result = board_default.assoc_at(coord_e1)
      strings = result.map(&:to_s)
      expect(strings).to eq(expected)
    end
  end

  describe '#square_at' do
    subject(:board_default) { described_class.from_fen_parser(fen_parser_default) }

    let(:fen_default) { Chess::ChessConstants::FEN_DEFAULT }
    let(:fen_parser_default) { Chess::FENParser.new(fen_default) }
    let(:expected) do
      "The Square is occupied by a King.\n\s\sThe King is white and has not moved."
    end

    it 'returns the Square located at the given coordinates' do
      coord_e1 = Chess::Coord.from_s('e1')
      result = board_default.square_at(coord_e1)
      string = result.to_s
      expect(string).to eq(expected)
    end
  end

  describe '#update_at' do
    subject(:board_default) { described_class.from_fen_parser(fen_parser_default) }

    let(:fen_default) { Chess::ChessConstants::FEN_DEFAULT }
    let(:fen_parser_default) { Chess::FENParser.new(fen_default) }
    let(:queen) { Chess::Queen.new(:white) }
    let(:before) do
      [
        'e4',
        'The Square is unoccupied.'
      ]
    end
    let(:after) do
      [
        'e4',
        "The Square is occupied by a Queen.\n\s\sThe Queen is white and has not moved."
      ]
    end

    it 'updates the occupant at the given coordinates' do
      coord_e4 = Chess::Coord.from_s('e4')
      expect { board_default.update_at(coord_e4, queen) }.to change \
        { board_default.assoc_at(coord_e4).map(&:to_s) }
        .from(before).to(after)
    end
  end

  describe '#empty_at' do
    subject(:board_default) { described_class.from_fen_parser(fen_parser_default) }

    let(:fen_default) { Chess::ChessConstants::FEN_DEFAULT }
    let(:fen_parser_default) { Chess::FENParser.new(fen_default) }
    let(:before) do
      [
        'e8',
        "The Square is occupied by a King.\n\s\sThe King is black and has not moved."
      ]
    end
    let(:after) do
      [
        'e8',
        'The Square is unoccupied.'
      ]
    end

    it 'empties the occupant at the given coordinates' do
      coord_e8 = Chess::Coord.from_s('e8')
      expect { board_default.empty_at(coord_e8) }.to change \
        { board_default.assoc_at(coord_e8).map(&:to_s) }
        .from(before).to(after)
    end
  end

  describe '#occupied_at?' do
    subject(:board_default) { described_class.from_fen_parser(fen_parser_default) }

    let(:fen_default) { Chess::ChessConstants::FEN_DEFAULT }
    let(:fen_parser_default) { Chess::FENParser.new(fen_default) }

    context 'when the Square at the given coordinates is occupied' do
      it 'returns true' do
        coord_e2 = Chess::Coord.from_s('e2')
        result = board_default.occupied_at?(coord_e2)
        expect(result).to be(true)
      end
    end

    context 'when the Square at the given coordinates is unoccupied' do
      it 'returns false' do
        coord_e3 = Chess::Coord.from_s('e3')
        result = board_default.occupied_at?(coord_e3)
        expect(result).to be(false)
      end
    end
  end

  describe '#unoccupied_at?' do
    subject(:board_default) { described_class.from_fen_parser(fen_parser_default) }

    let(:fen_default) { Chess::ChessConstants::FEN_DEFAULT }
    let(:fen_parser_default) { Chess::FENParser.new(fen_default) }

    context 'when the Square at the given coordinates is unoccupied' do
      it 'returns true' do
        coord_e3 = Chess::Coord.from_s('e3')
        result = board_default.unoccupied_at?(coord_e3)
        expect(result).to be(true)
      end
    end

    context 'when the Square at the given coordinates is occupied' do
      it 'returns false' do
        coord_e2 = Chess::Coord.from_s('e2')
        result = board_default.unoccupied_at?(coord_e2)
        expect(result).to be(false)
      end
    end
  end

  describe '#to_white_occupied_associations' do
    subject(:board_default) { described_class.from_fen_parser(fen_parser_default) }

    let(:fen_default) { Chess::ChessConstants::FEN_DEFAULT }
    let(:fen_parser_default) { Chess::FENParser.new(fen_default) }
    let(:expected) do
      {
        'a2' => "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved.",
        'b2' => "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved.",
        'c2' => "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved.",
        'd2' => "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved.",
        'e2' => "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved.",
        'f2' => "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved.",
        'g2' => "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved.",
        'h2' => "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved.",
        'a1' => "The Square is occupied by a Rook.\n\s\sThe Rook is white and has not moved.",
        'b1' => "The Square is occupied by a Knight.\n\s\sThe Knight is white and has not moved.",
        'c1' => "The Square is occupied by a Bishop.\n\s\sThe Bishop is white and has not moved.",
        'd1' => "The Square is occupied by a Queen.\n\s\sThe Queen is white and has not moved.",
        'e1' => "The Square is occupied by a King.\n\s\sThe King is white and has not moved.",
        'f1' => "The Square is occupied by a Bishop.\n\s\sThe Bishop is white and has not moved.",
        'g1' => "The Square is occupied by a Knight.\n\s\sThe Knight is white and has not moved.",
        'h1' => "The Square is occupied by a Rook.\n\s\sThe Rook is white and has not moved."
      }
    end

    it 'returns a hash containing only white-occupied associations' do
      result = board_default.to_white_occupied_associations
      result = result.transform_keys(&:to_s)
      result = result.transform_values(&:to_s)
      expect(result).to eq(expected)
    end
  end

  describe '#to_black_occupied_associations' do
    subject(:board_default) { described_class.from_fen_parser(fen_parser_default) }

    let(:fen_default) { Chess::ChessConstants::FEN_DEFAULT }
    let(:fen_parser_default) { Chess::FENParser.new(fen_default) }
    let(:expected) do
      {
        'a7' => "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved.",
        'b7' => "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved.",
        'c7' => "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved.",
        'd7' => "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved.",
        'e7' => "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved.",
        'f7' => "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved.",
        'g7' => "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved.",
        'h7' => "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved.",
        'a8' => "The Square is occupied by a Rook.\n\s\sThe Rook is black and has not moved.",
        'b8' => "The Square is occupied by a Knight.\n\s\sThe Knight is black and has not moved.",
        'c8' => "The Square is occupied by a Bishop.\n\s\sThe Bishop is black and has not moved.",
        'd8' => "The Square is occupied by a Queen.\n\s\sThe Queen is black and has not moved.",
        'e8' => "The Square is occupied by a King.\n\s\sThe King is black and has not moved.",
        'f8' => "The Square is occupied by a Bishop.\n\s\sThe Bishop is black and has not moved.",
        'g8' => "The Square is occupied by a Knight.\n\s\sThe Knight is black and has not moved.",
        'h8' => "The Square is occupied by a Rook.\n\s\sThe Rook is black and has not moved."
      }
    end

    it 'returns a hash containing only black-occupied associations' do
      result = board_default.to_black_occupied_associations
      result = result.transform_keys(&:to_s)
      result = result.transform_values(&:to_s)
      expect(result).to eq(expected)
    end
  end

  describe '#to_ranks' do
    subject(:board_default) { described_class.from_fen_parser(fen_parser_default) }

    let(:fen_default) { Chess::ChessConstants::FEN_DEFAULT }
    let(:fen_parser_default) { Chess::FENParser.new(fen_default) }
    let(:expected) do
      {
        8 => [
          "The Square is occupied by a Rook.\n\s\sThe Rook is black and has not moved.",
          "The Square is occupied by a Knight.\n\s\sThe Knight is black and has not moved.",
          "The Square is occupied by a Bishop.\n\s\sThe Bishop is black and has not moved.",
          "The Square is occupied by a Queen.\n\s\sThe Queen is black and has not moved.",
          "The Square is occupied by a King.\n\s\sThe King is black and has not moved.",
          "The Square is occupied by a Bishop.\n\s\sThe Bishop is black and has not moved.",
          "The Square is occupied by a Knight.\n\s\sThe Knight is black and has not moved.",
          "The Square is occupied by a Rook.\n\s\sThe Rook is black and has not moved."
        ],
        7 => [
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved.",
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved.",
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved.",
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved.",
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved.",
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved.",
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved.",
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is black and has not moved."
        ],
        6 => [
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.'
        ],
        5 => [
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.'
        ],
        4 => [
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.'
        ],
        3 => [
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.',
          'The Square is unoccupied.'
        ],
        2 => [
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved.",
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved.",
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved.",
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved.",
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved.",
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved.",
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved.",
          "The Square is occupied by a Pawn.\n\s\sThe Pawn is white and has not moved."
        ],
        1 => [
          "The Square is occupied by a Rook.\n\s\sThe Rook is white and has not moved.",
          "The Square is occupied by a Knight.\n\s\sThe Knight is white and has not moved.",
          "The Square is occupied by a Bishop.\n\s\sThe Bishop is white and has not moved.",
          "The Square is occupied by a Queen.\n\s\sThe Queen is white and has not moved.",
          "The Square is occupied by a King.\n\s\sThe King is white and has not moved.",
          "The Square is occupied by a Bishop.\n\s\sThe Bishop is white and has not moved.",
          "The Square is occupied by a Knight.\n\s\sThe Knight is white and has not moved.",
          "The Square is occupied by a Rook.\n\s\sThe Rook is white and has not moved."
        ]
      }
    end

    it 'returns a hash where each key is a rank integer pointing to an array of Squares' do
      result = board_default.to_ranks
      strings = result.transform_values do |square_a|
        square_a.map(&:to_s)
      end
      expect(strings).to eq(expected)
    end
  end
end
