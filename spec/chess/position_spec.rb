# frozen_string_literal: true

describe Chess::Position do
  describe '::from_fen_parser' do
    subject { described_class }

    context 'when constructing from a default FEN record' do
      let(:expected) do
        <<~HEREDOC
          Board:
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


          AuxPosData:
          Active color: w
          Castling availability: KQkq
          En passant target: -
          Half move clock: 0
          Full move number: 1

          Player playing white: w(white)

          Player playing black: b(black)

          Log:
          Metadata:


        HEREDOC
      end

      it 'returns a new default Position' do
        fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
        result = described_class.from_fen_parser(fen_parser_default, 'w', 'b')
        string = result.to_s
        expect(string).to eq(expected)
      end
    end
  end

  describe '#to_fen' do
    context 'when testing a default Position' do
      subject(:position_default) do
        fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
        described_class.from_fen_parser(fen_parser_default, 'w', 'b')
      end

      it 'returns a FEN record based on the Position' do
        result = position_default.to_fen
        expect(result).to eq(Chess::ChessConstants::FEN_DEFAULT)
      end
    end

    context 'when testing a non-default Position' do
      subject(:position_non_default) do
        fen_parser_non_default = Chess::FENParser.new(fen_non_default)
        described_class.from_fen_parser(fen_parser_non_default, 'w', 'b')
      end

      let(:fen_non_default) { 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1' }

      it 'returns a FEN record based on the Position' do
        result = position_non_default.to_fen
        expect(result).to eq(fen_non_default)
      end
    end
  end

  describe '#move' do
    subject(:position) do
      fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
      described_class.from_fen_parser(fen_parser_default, 'w', 'b')
    end

    context 'when unoccupied at the given source' do
      let(:source) { Chess::Coord.from_s('e4') }
      let(:destination) { Chess::Coord.from_s('e5') }

      it 'returns nil' do
        result = position.move(source, destination)
        expect(result).to be_nil
      end

      it 'changes nothing' do
        expect { position.move(source, destination) }
          .not_to(change { position })
      end
    end

    context 'when occupied at the given source and unoccupied at the given destination' do
      let(:source) { Chess::Coord.from_s('e2') }
      let(:destination) { Chess::Coord.from_s('e4') }
      let(:board) { position.instance_variable_get(:@board) }
      let(:source_piece) { board.square_at(source).occupant }
      let(:log) { position.instance_variable_get(:@log) }

      before do
        allow(source_piece).to receive(:increment_total_moves)
        allow(board).to receive(:empty_at).with(source)
        allow(board).to receive(:update_at).with(destination, source_piece)
        allow(log).to receive(:reset_metadata).with(:previous_capture)
        allow(log).to receive(:update_metadata).with(
          [:previous_source, source],
          [:previous_destination, destination]
        )
      end

      it 'sends #increment_total_moves to the source Piece' do
        position.move(source, destination)
        expect(source_piece).to have_received(:increment_total_moves)
      end

      it 'sends #empty_at to the Board with the source' do
        position.move(source, destination)
        expect(board).to have_received(:empty_at).with(source)
      end

      it 'sends #update_at to the Board with the destination and source Piece' do
        position.move(source, destination)
        expect(board).to have_received(:update_at).with(destination, source_piece)
      end

      it 'sends #reset_metadata to the Log with expected args' do
        position.move(source, destination)
        expect(log).to have_received(:reset_metadata).with(:previous_capture)
      end

      it 'sends #update_metadata to the Log with expected args' do
        position.move(source, destination)
        expect(log).to have_received(:update_metadata).with(
          [:previous_source, source],
          [:previous_destination, destination]
        )
      end
    end

    # rubocop:disable RSpec/MultipleMemoizedHelpers
    context 'when occupied at the given source and occupied at the given destination' do
      let(:source) { Chess::Coord.from_s('e4') }
      let(:destination) { Chess::Coord.from_s('e7') }
      let(:board) { position.instance_variable_get(:@board) }
      let(:source_piece) { board.square_at(source).occupant }
      let(:captured_piece) { board.square_at(destination).occupant }
      let(:log) { position.instance_variable_get(:@log) }

      before do
        board.update_at(source, Chess::Queen.new(:white))
        allow(source_piece).to receive(:increment_total_moves)
        allow(board).to receive(:empty_at).with(source)
        allow(board).to receive(:update_at).with(destination, source_piece)
        allow(log).to receive(:update_metadata).with(
          [:previous_capture, captured_piece],
          [:previous_source, source],
          [:previous_destination, destination]
        )
      end

      it 'sends #increment_total_moves to the source Piece' do
        position.move(source, destination)
        expect(source_piece).to have_received(:increment_total_moves)
      end

      it 'sends #empty_at to the Board with the source' do
        position.move(source, destination)
        expect(board).to have_received(:empty_at).with(source)
      end

      it 'sends #update_at to the Board with the destination and source Piece' do
        position.move(source, destination)
        expect(board).to have_received(:update_at).with(destination, source_piece)
      end

      it 'sends #update_metadata to the Log with expected args' do # rubocop:disable RSpec/ExampleLength
        position.move(source, destination)
        expect(log).to have_received(:update_metadata).with(
          [:previous_capture, captured_piece],
          [:previous_source, source],
          [:previous_destination, destination]
        )
      end
    end
    # rubocop: enable all
  end

  describe '#check?' do
    subject(:position) do
      fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
      described_class.from_fen_parser(fen_parser_default, 'w', 'b')
    end

    context 'when white is active and in check' do
      before { position.move(Chess::Coord.from_s('e1'), Chess::Coord.from_s('e6')) }

      it 'returns true' do
        result = position.check?
        expect(result).to be(true)
      end
    end

    context 'when white is active and not in check' do
      it 'returns false' do
        result = position.check?
        expect(result).to be(false)
      end
    end

    context 'when black is active and in check' do
      before do
        position.move(Chess::Coord.from_s('e8'), Chess::Coord.from_s('e3'))
        position.swap_active_player
      end

      it 'returns true' do
        result = position.check?
        expect(result).to be(true)
      end
    end

    context 'when black is active and not in check' do
      before { position.swap_active_player }

      it 'returns false' do
        result = position.check?
        expect(result).to be(false)
      end
    end
  end
end
