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

    context 'when occupied at the given Coord' do
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
end
