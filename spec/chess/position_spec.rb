# frozen_string_literal: true

describe Chess::Position do
  describe '::new_default' do
    subject { described_class }

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

        Player playing white: Player(white)

        Player playing black: Player(black)

        Log:
        Metadata:


      HEREDOC
    end

    it 'returns a new default Position' do
      result = described_class.new_default('Player', 'Player')
      string = result.to_s
      expect(string).to eq(expected)
    end
  end

  describe '#to_fen' do
    context 'when testing with a default Position' do
      subject(:position_default) { described_class.new_default('Player', 'Player') }

      it 'returns a FEN record based on the data' do
        result = position_default.to_fen
        expect(result).to eq(Chess::ChessConstants::FEN_DEFAULT)
      end
    end

    context 'when testing with an endgame Position' do
      subject(:position_endgame) do
        f_p = Chess::FENParser.new(fen_endgame)
        board = Chess::Board.from_fen_parser(f_p)
        aux_pos_data = Chess::AuxPosData.from_fen_parser(f_p)
        player_white = Chess::Player.new('Player', :white)
        player_black = Chess::Player.new('Player', :black)
        log = Chess::Log.new({})
        described_class.new(board, aux_pos_data, player_white, player_black, log)
      end

      let(:fen_endgame) { 'kq6/8/8/8/8/8/7P/7K b - - 0 65' }

      it 'returns a FEN record based on the data' do
        result = position_endgame.to_fen
        expect(result).to eq(fen_endgame)
      end
    end
  end

  describe '#move' do
    context 'when the move is invalid' do
      subject(:position_default) { described_class.new_default('Player', 'Player') }

      let(:source_coord) { Chess::Coord.from_s('e4') }
      let(:destination_coord) { Chess::Coord.from_s('e6') }

      it 'returns nil' do
        result = position_default.move(source_coord, destination_coord)
        expect(result).to be_nil
      end

      it 'changes nothing' do
        expect { position_default.move(source_coord, destination_coord) }.not_to(change \
          { position_default })
      end
    end

    # rubocop:disable RSpec/MultipleMemoizedHelpers
    context 'when the move is valid and results in a capture' do
      subject(:position_default) { described_class.new_default('Player', 'Player') }

      before do
        board.update_at(Chess::Coord.from_s('e4'), queen)
        allow(log).to receive(:update_metadata).with(
          [:previous_capture, captured_piece],
          [:previous_source, source_coord],
          [:previous_destination, destination_coord]
        )
        allow(queen).to receive(:increment_total_moves)
        allow(board).to receive(:empty_at).with(source_coord)
        allow(board).to receive(:update_at).with(destination_coord, queen)
      end

      let(:log) { position_default.instance_variable_get(:@log) }
      let(:board) { position_default.instance_variable_get(:@board) }
      let(:captured_piece) { board.square_at(destination_coord).occupant }
      let(:queen) { Chess::Queen.new(:white) }
      let(:source_coord) { Chess::Coord.from_s('e4') }
      let(:destination_coord) { Chess::Coord.from_s('e7') }

      # rubocop:disable RSpec/ExampleLength
      it 'sends #update_metadata to the Log with expected args' do
        position_default.move(source_coord, destination_coord)
        expect(log).to have_received(:update_metadata).with(
          [:previous_capture, captured_piece],
          [:previous_source, source_coord],
          [:previous_destination, destination_coord]
        )
      end
      # rubocop:enable all

      it 'sends #increment_total_moves to the moved Piece' do
        position_default.move(source_coord, destination_coord)
        expect(queen).to have_received(:increment_total_moves)
      end

      it 'sends #empty_at to the Board with the source Coord' do
        position_default.move(source_coord, destination_coord)
        expect(board).to have_received(:empty_at).with(source_coord)
      end

      it 'sends #update_at to the Board with the destination Coord and moved Piece' do
        position_default.move(source_coord, destination_coord)
        expect(board).to have_received(:update_at).with(destination_coord, queen)
      end
    end

    context 'when the move is valid and does not result in a capture' do
      subject(:position_default) { described_class.new_default('Player', 'Player') }

      before do
        board.update_at(Chess::Coord.from_s('e4'), queen)
        allow(log).to receive(:update_metadata).with(
          [:previous_source, source_coord],
          [:previous_destination, destination_coord]
        )
        allow(log).to receive(:reset_metadata).with(:previous_capture)
        allow(queen).to receive(:increment_total_moves)
        allow(board).to receive(:empty_at).with(source_coord)
        allow(board).to receive(:update_at).with(destination_coord, queen)
      end

      let(:log) { position_default.instance_variable_get(:@log) }
      let(:board) { position_default.instance_variable_get(:@board) }
      let(:queen) { Chess::Queen.new(:white) }
      let(:source_coord) { Chess::Coord.from_s('e4') }
      let(:destination_coord) { Chess::Coord.from_s('e6') }

      it 'sends #update_metadata to the Log with expected args' do
        position_default.move(source_coord, destination_coord)
        expect(log).to have_received(:update_metadata).with(
          [:previous_source, source_coord],
          [:previous_destination, destination_coord]
        )
      end

      it 'sends #reset_metadata to the Log with expected args' do
        position_default.move(source_coord, destination_coord)
        expect(log).to have_received(:reset_metadata).with(:previous_capture)
      end

      it 'sends #increment_total_moves to the moved Piece' do
        position_default.move(source_coord, destination_coord)
        expect(queen).to have_received(:increment_total_moves)
      end

      it 'sends #empty_at to the Board with the source Coord' do
        position_default.move(source_coord, destination_coord)
        expect(board).to have_received(:empty_at).with(source_coord)
      end

      it 'sends #update_at to the Board with the destination Coord and moved Piece' do
        position_default.move(source_coord, destination_coord)
        expect(board).to have_received(:update_at).with(destination_coord, queen)
      end
    end
  end

  describe '#valid_move?' do
    subject(:position_default) { described_class.new_default('Player', 'Player') }

    before do
      board = position_default.instance_variable_get(:@board)
      board.update_at(Chess::Coord.from_s('e4'), Chess::Queen.new(:white))
      board.update_at(Chess::Coord.from_s('e5'), Chess::Pawn.new(:white))
    end

    context 'when the given source is invalid' do
      it 'returns false' do
        source_coord = Chess::Coord.from_s('e6')
        destination_coord = Chess::Coord.from_s('e2')
        result = position_default.valid_move?(source_coord, destination_coord)
        expect(result).to be(false)
      end
    end

    context 'when the given source is valid, but the given destination is invalid' do
      let(:invalid_destinations) do
        %w[
          a8 b8 c8 d8 e8 f8 g8 h8
          a7 c7 d7 e7 f7 g7
          a6 b6 d6 e6 f6 h6
          a5 b5 c5 e5 g5 h5
          e4
          a3 b3 c3 g3 h3
          a2 b2 c2 d2 e2 f2 g2 h2
          a1 b1 c1 d1 e1 f1 g1 h1
        ].map { |coord_s| Chess::Coord.from_s(coord_s) }
      end

      it 'returns false' do
        source_coord = Chess::Coord.from_s('e4')
        result = invalid_destinations.none? do |destination_coord|
          position_default.valid_move?(source_coord, destination_coord)
        end
        expect(result).to be(true)
      end
    end

    context 'when the given source is valid and the given destination is valid' do
      let(:valid_destinations) do
        %w[
          b7 h7
          c6 g6
          d5 f5
          a4 b4 c4 d4 f4 g4 h4
          d3 e3 f3
        ].map { |coord_s| Chess::Coord.from_s(coord_s) }
      end

      it 'returns true' do
        source_coord = Chess::Coord.from_s('e4')
        result = valid_destinations.all? do |destination_coord|
          position_default.valid_move?(source_coord, destination_coord)
        end
        expect(result).to be(true)
      end
    end
  end

  describe '#to_adjacent_controlled_coords_from' do
    subject(:position_default) { described_class.new_default('Player', 'Player') }

    context 'when unoccupied at the given Coord' do
      it 'returns nil' do
        coord_e4 = Chess::Coord.from_s('e4')
        result = position_default.to_adjacent_controlled_coords_from(coord_e4)
        expect(result).to be_nil
      end
    end

    context 'when occupied at the given Coord' do
      let(:coord_e4) { Chess::Coord.from_s('e4') }
      let(:expected) do
        {
          north: %w[e5 e6],
          east: %w[f4 g4 h4],
          west: %w[d4 c4 b4 a4],
          north_east: %w[f5 g6],
          south_east: %w[f3],
          south_west: %w[d3],
          north_west: %w[d5 c6]
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end

      before do
        queen = Chess::Queen.new(:white)
        pawn = Chess::Pawn.new(:white)
        board = position_default.instance_variable_get(:@board)
        board.update_at(coord_e4, queen)
        board.update_at(Chess::Coord.from_s('e3'), pawn)
      end

      it 'returns a hash of the controlled adjacencies per direction' do
        result = position_default.to_adjacent_controlled_coords_from(coord_e4)
        expect(result).to eq(expected)
      end
    end
  end

  describe '#to_adjacent_attacked_coords_from' do
    subject(:position_default) { described_class.new_default('Player', 'Player') }

    context 'when unoccupied at the given Coord' do
      it 'returns nil' do
        coord_e4 = Chess::Coord.from_s('e4')
        result = position_default.to_adjacent_attacked_coords_from(coord_e4)
        expect(result).to be_nil
      end
    end

    context 'when occupied at the given Coord by a Queen' do
      let(:coord_e4) { Chess::Coord.from_s('e4') }
      let(:expected) do
        {
          north_west: %w[b7],
          north_east: %w[h7]
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end

      before do
        queen = Chess::Queen.new(:white)
        pawn1 = Chess::Pawn.new(:white)
        pawn2 = Chess::Pawn.new(:white)
        board = position_default.instance_variable_get(:@board)
        board.update_at(coord_e4, queen)
        board.update_at(Chess::Coord.from_s('e3'), pawn1)
        board.update_at(Chess::Coord.from_s('e5'), pawn2)
      end

      it 'returns a hash of attacked adjacencies per direction' do
        result = position_default.to_adjacent_attacked_coords_from(coord_e4)
        expect(result).to eq(expected)
      end
    end

    context 'when occupied at the given Coord by a Pawn' do
      let(:coord_e3) { Chess::Coord.from_s('e3') }
      let(:expected) do
        {
          south_west: %w[d2],
          south_east: %w[f2]
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end

      before do
        pawn = Chess::Pawn.new(:black)
        board = position_default.instance_variable_get(:@board)
        board.update_at(coord_e3, pawn)
      end

      it 'returns a hash of attacked adjacencies per direction' do
        result = position_default.to_adjacent_attacked_coords_from(coord_e3)
        expect(result).to eq(expected)
      end
    end
  end

  describe '#to_active_player' do
    context 'when white is active' do
      subject(:position_white_active) { described_class.new_default('Player', 'Player') }

      it 'returns the Player playing white' do
        result = position_white_active.to_active_player
        expect(result).to be(position_white_active.instance_variable_get(:@player_white))
      end
    end

    context 'when black is active' do
      subject(:position_black_active) do
        position = described_class.new_default('Player', 'Player')
        position.swap_active_player
        position
      end

      it 'returns the Player playing black' do
        result = position_black_active.to_active_player
        expect(result).to be(position_black_active.instance_variable_get(:@player_black))
      end
    end
  end

  describe '#to_inactive_player' do
    context 'when white is active' do
      subject(:position_white_active) { described_class.new_default('Player', 'Player') }

      it 'returns the Player playing black' do
        result = position_white_active.to_inactive_player
        expect(result).to be(position_white_active.instance_variable_get(:@player_black))
      end
    end

    context 'when black is active' do
      subject(:position_black_active) do
        position = described_class.new_default('Player', 'Player')
        position.swap_active_player
        position
      end

      it 'returns the Player playing white' do
        result = position_black_active.to_inactive_player
        expect(result).to be(position_black_active.instance_variable_get(:@player_white))
      end
    end
  end

  describe '#swap_active_player' do
    # rubocop:disable RSpec/ExpectChange
    context 'when white is active' do
      subject(:position_white_active) { described_class.new_default('Player', 'Player') }

      it 'swaps the active Player to the Player playing black' do
        expect { position_white_active.swap_active_player }.to change \
          { position_white_active.to_active_player }
          .from(position_white_active.instance_variable_get(:@player_white))
          .to(position_white_active.instance_variable_get(:@player_black))
      end
    end

    context 'when black is active' do
      subject(:position_black_active) do
        position = described_class.new_default('Player', 'Player')
        position.swap_active_player
        position
      end

      it 'swaps the active Player to the Player playing white' do
        expect { position_black_active.swap_active_player }.to change \
          { position_black_active.to_active_player }
          .from(position_black_active.instance_variable_get(:@player_black))
          .to(position_black_active.instance_variable_get(:@player_white))
      end
    end
    # rubocop:enable all
  end

  describe '#dump_log' do
    subject(:position_default) { described_class.new_default('Player', 'Player') }

    let(:log) { position_default.instance_variable_get(:@log) }

    it 'sends #dump to the Log' do
      allow(log).to receive(:dump)
      position_default.dump_log
      expect(log).to have_received(:dump)
    end
  end

  describe '#valid_source?' do
    subject(:position_default) { described_class.new_default('Player', 'Player') }

    context 'when passed any Coord corresponding to one of the active Player\'s Squares' do
      let(:valid_coords) do
        %w[a2 b2 c2 d2 e2 f2 g2 h2 a1 b1 c1 d1 e1 f1 g1 h1].map do |coord_s|
          Chess::Coord.from_s(coord_s)
        end
      end

      it 'returns true' do
        result = valid_coords.all? { |coord| position_default.valid_source?(coord) }
        expect(result).to be(true)
      end
    end

    context 'when passed any Coord corresponding to an unoccupied Square' do
      let(:unoccupied_coords) do
        %w[
          a3 b3 c3 d3 e3 f3 g3 h3
          a4 b4 c4 d4 e4 f4 g4 h4
          a5 b5 c5 d5 e5 f5 g5 h5
          a6 b6 c6 d6 e6 f6 g6 h6
        ].map do |coord_s|
          Chess::Coord.from_s(coord_s)
        end
      end

      it 'returns false' do
        result = unoccupied_coords.none? { |coord| position_default.valid_source?(coord) }
        expect(result).to be(true)
      end
    end

    context 'when passed any Coord corresponding to one of the inactive Player\'s Squares' do
      let(:inactive_coords) do
        %w[a7 b7 c7 d7 e7 f7 g7 h7 a8 b8 c8 d8 e8 f8 g8 h8].map do |coord_s|
          Chess::Coord.from_s(coord_s)
        end
      end

      it 'returns false' do
        result = inactive_coords.none? { |coord| position_default.valid_source?(coord) }
        expect(result).to be(true)
      end
    end
  end

  describe '#select_source' do
    subject(:position_default) { described_class.new_default('Player', 'Player') }

    let(:log) { position_default.instance_variable_get(:@log) }
    let(:coord_invalid) { Chess::Coord.from_s('e4') }
    let(:coord_valid) { Chess::Coord.from_s('e2') }
    let(:controlled_a) { position_default.to_adjacent_controlled_coords_from(coord_valid).values.flatten }
    let(:attacked_a) { position_default.to_adjacent_attacked_coords_from(coord_valid).values.flatten }

    context 'when passed an invalid source Coord' do
      it 'returns nil' do
        result = position_default.select_source(coord_invalid)
        expect(result).to be_nil
      end

      it 'changes nothing' do
        expect { position_default.select_source(coord_invalid) }.not_to(change \
          { position_default })
      end
    end

    context 'when passed a valid source Coord' do
      before do
        allow(log).to receive(:update_metadata).with(
          [:current_source, coord_valid],
          [:currently_controlled, controlled_a],
          [:currently_attacked, attacked_a]
        )
      end

      # rubocop:disable RSpec/ExampleLength
      it 'sends #update_metadata to the Log with the expected args' do
        position_default.select_source(coord_valid)
        expect(log).to have_received(:update_metadata).with(
          [:current_source, coord_valid],
          [:currently_controlled, controlled_a],
          [:currently_attacked, attacked_a]
        )
      end
      # rubocop: enable all
    end
  end

  describe '#deselect_source' do
    subject(:position_default) { described_class.new_default('Player', 'Player') }

    let(:log) { position_default.instance_variable_get(:@log) }

    before do
      allow(log).to receive(:reset_metadata).with(
        :current_source, :currently_controlled, :currently_attacked
      )
    end

    it 'sends #reset_metadata to the Log with the expected args' do
      position_default.deselect_source
      expect(log).to have_received(:reset_metadata).with(
        :current_source, :currently_controlled, :currently_attacked
      )
    end
  end

  describe '#to_active_player_sources' do
    subject(:position_default) { described_class.new_default('Player', 'Player') }

    let(:expected) do
      %w[a2 b2 c2 d2 e2 f2 g2 h2 a1 b1 c1 d1 e1 f1 g1 h1].map do |coord_s|
        Chess::Coord.from_s(coord_s)
      end
    end

    it 'returns an array of the active Player\'s possible source Coords' do
      result = position_default.to_active_player_sources
      expect(result).to eq(expected)
    end
  end

  describe '#to_board_ranks' do
    subject(:position_default) { described_class.new_default('Player', 'Player') }

    let(:board) { position_default.instance_variable_get(:@board) }

    before { allow(board).to receive(:to_ranks) }

    it 'sends #to_ranks to the Board' do
      position_default.to_board_ranks
      expect(board).to have_received(:to_ranks)
    end
  end
end
