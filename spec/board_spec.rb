# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  let(:default_board_str) do
    <<~HEREDOC
      rank: 8
        a8: <Square>: [@algebraic_coords: a8, @occupant: <Rook>: [@algebraic_coords: a8, @color: black, @total_moves: 0]]
        b8: <Square>: [@algebraic_coords: b8, @occupant: <Knight>: [@algebraic_coords: b8, @color: black, @total_moves: 0]]
        c8: <Square>: [@algebraic_coords: c8, @occupant: <Bishop>: [@algebraic_coords: c8, @color: black, @total_moves: 0]]
        d8: <Square>: [@algebraic_coords: d8, @occupant: <Queen>: [@algebraic_coords: d8, @color: black, @total_moves: 0]]
        e8: <Square>: [@algebraic_coords: e8, @occupant: <King>: [@algebraic_coords: e8, @color: black, @total_moves: 0]]
        f8: <Square>: [@algebraic_coords: f8, @occupant: <Bishop>: [@algebraic_coords: f8, @color: black, @total_moves: 0]]
        g8: <Square>: [@algebraic_coords: g8, @occupant: <Knight>: [@algebraic_coords: g8, @color: black, @total_moves: 0]]
        h8: <Square>: [@algebraic_coords: h8, @occupant: <Rook>: [@algebraic_coords: h8, @color: black, @total_moves: 0]]
      rank: 7
        a7: <Square>: [@algebraic_coords: a7, @occupant: <Pawn>: [@algebraic_coords: a7, @color: black, @total_moves: 0]]
        b7: <Square>: [@algebraic_coords: b7, @occupant: <Pawn>: [@algebraic_coords: b7, @color: black, @total_moves: 0]]
        c7: <Square>: [@algebraic_coords: c7, @occupant: <Pawn>: [@algebraic_coords: c7, @color: black, @total_moves: 0]]
        d7: <Square>: [@algebraic_coords: d7, @occupant: <Pawn>: [@algebraic_coords: d7, @color: black, @total_moves: 0]]
        e7: <Square>: [@algebraic_coords: e7, @occupant: <Pawn>: [@algebraic_coords: e7, @color: black, @total_moves: 0]]
        f7: <Square>: [@algebraic_coords: f7, @occupant: <Pawn>: [@algebraic_coords: f7, @color: black, @total_moves: 0]]
        g7: <Square>: [@algebraic_coords: g7, @occupant: <Pawn>: [@algebraic_coords: g7, @color: black, @total_moves: 0]]
        h7: <Square>: [@algebraic_coords: h7, @occupant: <Pawn>: [@algebraic_coords: h7, @color: black, @total_moves: 0]]
      rank: 6
        a6: <Square>: [@algebraic_coords: a6, @occupant: ]
        b6: <Square>: [@algebraic_coords: b6, @occupant: ]
        c6: <Square>: [@algebraic_coords: c6, @occupant: ]
        d6: <Square>: [@algebraic_coords: d6, @occupant: ]
        e6: <Square>: [@algebraic_coords: e6, @occupant: ]
        f6: <Square>: [@algebraic_coords: f6, @occupant: ]
        g6: <Square>: [@algebraic_coords: g6, @occupant: ]
        h6: <Square>: [@algebraic_coords: h6, @occupant: ]
      rank: 5
        a5: <Square>: [@algebraic_coords: a5, @occupant: ]
        b5: <Square>: [@algebraic_coords: b5, @occupant: ]
        c5: <Square>: [@algebraic_coords: c5, @occupant: ]
        d5: <Square>: [@algebraic_coords: d5, @occupant: ]
        e5: <Square>: [@algebraic_coords: e5, @occupant: ]
        f5: <Square>: [@algebraic_coords: f5, @occupant: ]
        g5: <Square>: [@algebraic_coords: g5, @occupant: ]
        h5: <Square>: [@algebraic_coords: h5, @occupant: ]
      rank: 4
        a4: <Square>: [@algebraic_coords: a4, @occupant: ]
        b4: <Square>: [@algebraic_coords: b4, @occupant: ]
        c4: <Square>: [@algebraic_coords: c4, @occupant: ]
        d4: <Square>: [@algebraic_coords: d4, @occupant: ]
        e4: <Square>: [@algebraic_coords: e4, @occupant: ]
        f4: <Square>: [@algebraic_coords: f4, @occupant: ]
        g4: <Square>: [@algebraic_coords: g4, @occupant: ]
        h4: <Square>: [@algebraic_coords: h4, @occupant: ]
      rank: 3
        a3: <Square>: [@algebraic_coords: a3, @occupant: ]
        b3: <Square>: [@algebraic_coords: b3, @occupant: ]
        c3: <Square>: [@algebraic_coords: c3, @occupant: ]
        d3: <Square>: [@algebraic_coords: d3, @occupant: ]
        e3: <Square>: [@algebraic_coords: e3, @occupant: ]
        f3: <Square>: [@algebraic_coords: f3, @occupant: ]
        g3: <Square>: [@algebraic_coords: g3, @occupant: ]
        h3: <Square>: [@algebraic_coords: h3, @occupant: ]
      rank: 2
        a2: <Square>: [@algebraic_coords: a2, @occupant: <Pawn>: [@algebraic_coords: a2, @color: white, @total_moves: 0]]
        b2: <Square>: [@algebraic_coords: b2, @occupant: <Pawn>: [@algebraic_coords: b2, @color: white, @total_moves: 0]]
        c2: <Square>: [@algebraic_coords: c2, @occupant: <Pawn>: [@algebraic_coords: c2, @color: white, @total_moves: 0]]
        d2: <Square>: [@algebraic_coords: d2, @occupant: <Pawn>: [@algebraic_coords: d2, @color: white, @total_moves: 0]]
        e2: <Square>: [@algebraic_coords: e2, @occupant: <Pawn>: [@algebraic_coords: e2, @color: white, @total_moves: 0]]
        f2: <Square>: [@algebraic_coords: f2, @occupant: <Pawn>: [@algebraic_coords: f2, @color: white, @total_moves: 0]]
        g2: <Square>: [@algebraic_coords: g2, @occupant: <Pawn>: [@algebraic_coords: g2, @color: white, @total_moves: 0]]
        h2: <Square>: [@algebraic_coords: h2, @occupant: <Pawn>: [@algebraic_coords: h2, @color: white, @total_moves: 0]]
      rank: 1
        a1: <Square>: [@algebraic_coords: a1, @occupant: <Rook>: [@algebraic_coords: a1, @color: white, @total_moves: 0]]
        b1: <Square>: [@algebraic_coords: b1, @occupant: <Knight>: [@algebraic_coords: b1, @color: white, @total_moves: 0]]
        c1: <Square>: [@algebraic_coords: c1, @occupant: <Bishop>: [@algebraic_coords: c1, @color: white, @total_moves: 0]]
        d1: <Square>: [@algebraic_coords: d1, @occupant: <Queen>: [@algebraic_coords: d1, @color: white, @total_moves: 0]]
        e1: <Square>: [@algebraic_coords: e1, @occupant: <King>: [@algebraic_coords: e1, @color: white, @total_moves: 0]]
        f1: <Square>: [@algebraic_coords: f1, @occupant: <Bishop>: [@algebraic_coords: f1, @color: white, @total_moves: 0]]
        g1: <Square>: [@algebraic_coords: g1, @occupant: <Knight>: [@algebraic_coords: g1, @color: white, @total_moves: 0]]
        h1: <Square>: [@algebraic_coords: h1, @occupant: <Rook>: [@algebraic_coords: h1, @color: white, @total_moves: 0]]
    HEREDOC
  end
  let(:default_piece_placement) do
    { 8 => { a8: 'r', b8: 'n', c8: 'b', d8: 'q', e8: 'k', f8: 'b', g8: 'n', h8: 'r' },
      7 => { a7: 'p', b7: 'p', c7: 'p', d7: 'p', e7: 'p', f7: 'p', g7: 'p', h7: 'p' },
      6 => { a6: '-', b6: '-', c6: '-', d6: '-', e6: '-', f6: '-', g6: '-', h6: '-' },
      5 => { a5: '-', b5: '-', c5: '-', d5: '-', e5: '-', f5: '-', g5: '-', h5: '-' },
      4 => { a4: '-', b4: '-', c4: '-', d4: '-', e4: '-', f4: '-', g4: '-', h4: '-' },
      3 => { a3: '-', b3: '-', c3: '-', d3: '-', e3: '-', f3: '-', g3: '-', h3: '-' },
      2 => { a2: 'P', b2: 'P', c2: 'P', d2: 'P', e2: 'P', f2: 'P', g2: 'P', h2: 'P' },
      1 => { a1: 'R', b1: 'N', c1: 'B', d1: 'Q', e1: 'K', f1: 'B', g1: 'N', h1: 'R' } }
  end

  describe '::from_piece_placement' do
    context 'when constructing from the default piece placement' do
      subject { described_class }

      it 'returns a board object with the expected state' do
        result = described_class.from_piece_placement(default_piece_placement)
        string = result.to_s
        expect(string).to eq(default_board_str)
      end
    end
  end

  describe '#access_square' do
    context 'when accessing the square at coordinates e4 on a default board' do
      subject(:board_default) { described_class.from_piece_placement(default_piece_placement) }

      it 'returns the square at coordinates e4' do
        result = board_default.access_square('e4')
        string = result.to_s
        expect(string).to eq('<Square>: [@algebraic_coords: e4, @occupant: ]')
      end
    end
  end

  describe '#to_s' do
    context 'when testing with a default board' do
      subject(:board_default) { described_class.from_piece_placement(default_piece_placement) }

      it 'returns a string describing the state of the board' do
        result = board_default.to_s
        expect(result).to eq(default_board_str)
      end
    end
  end
end
