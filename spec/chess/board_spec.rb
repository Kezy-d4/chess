# frozen_string_literal: true

describe Chess::Board do
  describe '::from_fen_parser' do
    context 'when passed a FENParser with a default FEN record' do
      subject { described_class }

      it 'returns a Board with the expected state' do
        fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
        result = described_class.from_fen_parser(fen_parser_default)
        string = result.to_partial_fen
        expect(string).to eq('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR')
      end
    end
  end

  describe '#to_partial_fen' do
    context 'when testing with a default Board' do
      subject(:board_default) do
        fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
        described_class.from_fen_parser(fen_parser_default)
      end

      it 'returns a partial FEN record based on the data' do
        result = board_default.to_partial_fen
        expect(result).to eq('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR')
      end
    end

    context 'when testing with a non-default Board' do
      subject(:board_non_default) do
        fen_non_default = 'kq6/8/8/8/8/8/7P/7K b - - 0 65'
        fen_parser_non_default = Chess::FENParser.new(fen_non_default)
        described_class.from_fen_parser(fen_parser_non_default)
      end

      it 'returns a partial FEN record based on the data' do
        result = board_non_default.to_partial_fen
        expect(result).to eq('kq6/8/8/8/8/8/7P/7K')
      end
    end
  end

  describe '#assoc_at' do
    subject(:board_default) do
      fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
      described_class.from_fen_parser(fen_parser_default)
    end

    let(:expected) do
      [
        'e1',
        'The Square is occupied by a white King.'
      ]
    end

    it 'returns the association at the given Coord' do
      coord_e1 = Chess::Coord.from_s('e1')
      result = board_default.assoc_at(coord_e1)
      strings = result.map(&:to_s)
      expect(strings).to eq(expected)
    end
  end

  describe '#square_at' do
    subject(:board_default) do
      fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
      described_class.from_fen_parser(fen_parser_default)
    end

    it 'returns the Square at the given Coord' do
      coord_e1 = Chess::Coord.from_s('e1')
      result = board_default.square_at(coord_e1)
      string = result.to_s
      expect(string).to eq('The Square is occupied by a white King.')
    end
  end

  describe '#update_at' do
    subject(:board_default) do
      fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
      described_class.from_fen_parser(fen_parser_default)
    end

    let(:before) do
      [
        'e4',
        'The Square is unoccupied.'
      ]
    end
    let(:after) do
      [
        'e4',
        'The Square is occupied by a white Queen.'
      ]
    end

    it 'updates the occupant at the given Coord' do
      coord_e4 = Chess::Coord.from_s('e4')
      queen = Chess::Queen.new(:white)
      expect { board_default.update_at(coord_e4, queen) }.to change \
        { board_default.assoc_at(coord_e4).map(&:to_s) }.from(before).to(after)
    end
  end

  describe '#empty_at' do
    subject(:board_default) do
      fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
      described_class.from_fen_parser(fen_parser_default)
    end

    let(:before) do
      [
        'e8',
        'The Square is occupied by a black King.'
      ]
    end
    let(:after) do
      [
        'e8',
        'The Square is unoccupied.'
      ]
    end

    it 'empties the occupant at the given Coord' do
      coord_e8 = Chess::Coord.from_s('e8')
      expect { board_default.empty_at(coord_e8) }.to change \
        { board_default.assoc_at(coord_e8).map(&:to_s) }.from(before).to(after)
    end
  end

  describe '#occupied_at?' do
    subject(:board_default) do
      fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
      described_class.from_fen_parser(fen_parser_default)
    end

    context 'when occupied at the given Coord' do
      it 'returns true' do
        coord_e2 = Chess::Coord.from_s('e2')
        result = board_default.occupied_at?(coord_e2)
        expect(result).to be(true)
      end
    end

    context 'when unoccupied at the given Coord' do
      it 'returns false' do
        coord_e3 = Chess::Coord.from_s('e3')
        result = board_default.occupied_at?(coord_e3)
        expect(result).to be(false)
      end
    end
  end

  describe '#unoccupied_at?' do
    subject(:board_default) do
      fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
      described_class.from_fen_parser(fen_parser_default)
    end

    context 'when unoccupied at the given Coord' do
      it 'returns true' do
        coord_e3 = Chess::Coord.from_s('e3')
        result = board_default.unoccupied_at?(coord_e3)
        expect(result).to be(true)
      end
    end

    context 'when occupied at the given Coord' do
      it 'returns false' do
        coord_e2 = Chess::Coord.from_s('e2')
        result = board_default.unoccupied_at?(coord_e2)
        expect(result).to be(false)
      end
    end
  end

  describe '#to_adjacent_controlled_coords_from' do
    context 'when testing Immortal Game after 11.Rg1' do
      subject(:board_mid) do
        fen_immortal = 'rnb1kb1r/p2p1ppp/2p2n2/1B3Nq1/4PpP1/3P4/PPP4P/RNBQ1KR1 b kq - 2 11'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      let(:coord_f6_expectation) do
        {
          north_east_left: ['g8'],
          south_east_right: ['h5'],
          south_west_left: ['d5']
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end
      let(:coord_g5_expectation) do
        {
          north: ['g6'],
          east: ['h5'],
          north_east: ['h6'],
          south_east: ['h4']
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end
      let(:coord_c6_expectation) do
        {
          south: ['c5']
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end
      let(:coord_c2_expectation) do
        {
          north: %w[c3 c4]
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end

      example 'Coord a1' do
        coord_a1 = Chess::Coord.from_s('a1')
        result = board_mid.to_adjacent_controlled_coords_from(coord_a1)
        expect(result).to be_a(Hash).and be_empty
      end

      example 'Coord e3' do
        coord_e3 = Chess::Coord.from_s('e3')
        result = board_mid.to_adjacent_controlled_coords_from(coord_e3)
        expect(result).to be_a(Hash).and be_empty
      end

      example 'Coord f6' do
        coord_f6 = Chess::Coord.from_s('f6')
        result = board_mid.to_adjacent_controlled_coords_from(coord_f6)
        expect(result).to eq(coord_f6_expectation)
      end

      example 'Coord g5' do
        coord_g5 = Chess::Coord.from_s('g5')
        result = board_mid.to_adjacent_controlled_coords_from(coord_g5)
        expect(result).to eq(coord_g5_expectation)
      end

      example 'Coord c6' do
        coord_c6 = Chess::Coord.from_s('c6')
        result = board_mid.to_adjacent_controlled_coords_from(coord_c6)
        expect(result).to eq(coord_c6_expectation)
      end

      example 'Coord c2' do
        coord_c2 = Chess::Coord.from_s('c2')
        result = board_mid.to_adjacent_controlled_coords_from(coord_c2)
        expect(result).to eq(coord_c2_expectation)
      end
    end
  end

  describe '#to_adjacent_attacked_coords_from' do
    context 'when testing Immortal Game after 11.Rg1' do
      subject(:board_mid) do
        fen_immortal = 'rnb1kb1r/p2p1ppp/2p2n2/1B3Nq1/4PpP1/3P4/PPP4P/RNBQ1KR1 b kq - 2 11'
        fen_parser_immortal = Chess::FENParser.new(fen_immortal)
        described_class.from_fen_parser(fen_parser_immortal)
      end

      let(:coord_g5_expectation) do
        {
          west: ['f5'],
          south: ['g4']
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end
      let(:coord_f5_expectation) do
        {
          north_east_left: ['g7']
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end
      let(:coord_c6_expectation) do
        {
          south_west: ['b5']
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end
      let(:coord_b5_expectation) do
        {
          north_east: ['c6']
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end

      example 'Coord e4' do
        coord_e4 = Chess::Coord.from_s('e4')
        result = board_mid.to_adjacent_attacked_coords_from(coord_e4)
        expect(result).to be_a(Hash).and be_empty
      end

      example 'Coord g5' do
        coord_g5 = Chess::Coord.from_s('g5')
        result = board_mid.to_adjacent_attacked_coords_from(coord_g5)
        expect(result).to eq(coord_g5_expectation)
      end

      example 'Coord f5' do
        coord_f5 = Chess::Coord.from_s('f5')
        result = board_mid.to_adjacent_attacked_coords_from(coord_f5)
        expect(result).to eq(coord_f5_expectation)
      end

      example 'Coord c6' do
        coord_c6 = Chess::Coord.from_s('c6')
        result = board_mid.to_adjacent_attacked_coords_from(coord_c6)
        expect(result).to eq(coord_c6_expectation)
      end

      example 'Coord b5' do
        coord_b5 = Chess::Coord.from_s('b5')
        result = board_mid.to_adjacent_attacked_coords_from(coord_b5)
        expect(result).to eq(coord_b5_expectation)
      end

      example 'Coord e5' do
        coord_e5 = Chess::Coord.from_s('e5')
        result = board_mid.to_adjacent_attacked_coords_from(coord_e5)
        expect(result).to be_a(Hash).and be_empty
      end
    end

    context 'when passing an en passant target' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      subject(:board_en_passant) do
        fen_en_passant = 'r1bqkbnr/ppp1p1pp/n2p4/4Pp2/4N3/8/PPPP1PPP/RNBQKB1R w KQkq f6 0 6'
        fen_parser_en_passant = Chess::FENParser.new(fen_en_passant)
        described_class.from_fen_parser(fen_parser_en_passant)
      end

      let(:en_passant_target) { 'f6' }
      let(:coord_e5_expectation) do
        {
          north_west: ['d6'],
          north_east: ['f6']
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end
      let(:coord_e4_expectation) do
        {
          north_west_right: ['d6']
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end
      let(:coord_f5_expectation) do
        {
          south_west: ['e4']
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end
      let(:coord_d6_expectation) do
        {
          south_east: ['e5']
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end
      let(:coord_f1_expectation) do
        {
          north_west: ['a6']
        }.transform_values do |coord_a|
          coord_a.map { |coord_s| Chess::Coord.from_s(coord_s) }
        end
      end

      example 'Coord e5' do
        coord_e5 = Chess::Coord.from_s('e5')
        result = board_en_passant.to_adjacent_attacked_coords_from(coord_e5, en_passant_target)
        expect(result).to eq(coord_e5_expectation)
      end

      example 'Coord e4' do
        coord_e4 = Chess::Coord.from_s('e4')
        result = board_en_passant.to_adjacent_attacked_coords_from(coord_e4, en_passant_target)
        expect(result).to eq(coord_e4_expectation)
      end

      example 'Coord f5' do
        coord_f5 = Chess::Coord.from_s('f5')
        result = board_en_passant.to_adjacent_attacked_coords_from(coord_f5, en_passant_target)
        expect(result).to eq(coord_f5_expectation)
      end

      example 'Coord d6' do
        coord_d6 = Chess::Coord.from_s('d6')
        result = board_en_passant.to_adjacent_attacked_coords_from(coord_d6, en_passant_target)
        expect(result).to eq(coord_d6_expectation)
      end

      example 'Coord f1' do
        coord_f1 = Chess::Coord.from_s('f1')
        result = board_en_passant.to_adjacent_attacked_coords_from(coord_f1, en_passant_target)
        expect(result).to eq(coord_f1_expectation)
      end

      example 'Coord d1' do
        coord_d1 = Chess::Coord.from_s('d1')
        result = board_en_passant.to_adjacent_attacked_coords_from(coord_d1, en_passant_target)
        expect(result).to be_a(Hash).and be_empty
      end

      example 'Coord d8' do
        coord_d8 = Chess::Coord.from_s('d8')
        result = board_en_passant.to_adjacent_attacked_coords_from(coord_d8, en_passant_target)
        expect(result).to be_a(Hash).and be_empty
      end
    end
  end

  describe '#to_occupied_associations' do
    subject(:board_default) do
      fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
      described_class.from_fen_parser(fen_parser_default)
    end

    context 'when passed a white color' do
      let(:expected) do
        {
          'a2' => 'The Square is occupied by a white Pawn.',
          'b2' => 'The Square is occupied by a white Pawn.',
          'c2' => 'The Square is occupied by a white Pawn.',
          'd2' => 'The Square is occupied by a white Pawn.',
          'e2' => 'The Square is occupied by a white Pawn.',
          'f2' => 'The Square is occupied by a white Pawn.',
          'g2' => 'The Square is occupied by a white Pawn.',
          'h2' => 'The Square is occupied by a white Pawn.',
          'a1' => 'The Square is occupied by a white Rook.',
          'b1' => 'The Square is occupied by a white Knight.',
          'c1' => 'The Square is occupied by a white Bishop.',
          'd1' => 'The Square is occupied by a white Queen.',
          'e1' => 'The Square is occupied by a white King.',
          'f1' => 'The Square is occupied by a white Bishop.',
          'g1' => 'The Square is occupied by a white Knight.',
          'h1' => 'The Square is occupied by a white Rook.'
        }
      end

      it 'returns a hash containing only white-occupied associations' do
        result = board_default.to_occupied_associations(:white)
        result = result.transform_keys(&:to_s)
        result = result.transform_values(&:to_s)
        expect(result).to eq(expected)
      end
    end

    context 'when passed a black color' do
      let(:expected) do
        {
          'a7' => 'The Square is occupied by a black Pawn.',
          'b7' => 'The Square is occupied by a black Pawn.',
          'c7' => 'The Square is occupied by a black Pawn.',
          'd7' => 'The Square is occupied by a black Pawn.',
          'e7' => 'The Square is occupied by a black Pawn.',
          'f7' => 'The Square is occupied by a black Pawn.',
          'g7' => 'The Square is occupied by a black Pawn.',
          'h7' => 'The Square is occupied by a black Pawn.',
          'a8' => 'The Square is occupied by a black Rook.',
          'b8' => 'The Square is occupied by a black Knight.',
          'c8' => 'The Square is occupied by a black Bishop.',
          'd8' => 'The Square is occupied by a black Queen.',
          'e8' => 'The Square is occupied by a black King.',
          'f8' => 'The Square is occupied by a black Bishop.',
          'g8' => 'The Square is occupied by a black Knight.',
          'h8' => 'The Square is occupied by a black Rook.'
        }
      end

      it 'returns a hash containing only black-occupied associations' do
        result = board_default.to_occupied_associations(:black)
        result = result.transform_keys(&:to_s)
        result = result.transform_values(&:to_s)
        expect(result).to eq(expected)
      end
    end
  end

  describe '#to_ranks' do
    subject(:board_default) do
      fen_parser_default = Chess::FENParser.new(Chess::ChessConstants::FEN_DEFAULT)
      described_class.from_fen_parser(fen_parser_default)
    end

    let(:expected) do
      {
        8 => [
          'The Square is occupied by a black Rook.',
          'The Square is occupied by a black Knight.',
          'The Square is occupied by a black Bishop.',
          'The Square is occupied by a black Queen.',
          'The Square is occupied by a black King.',
          'The Square is occupied by a black Bishop.',
          'The Square is occupied by a black Knight.',
          'The Square is occupied by a black Rook.'
        ],
        7 => [
          'The Square is occupied by a black Pawn.',
          'The Square is occupied by a black Pawn.',
          'The Square is occupied by a black Pawn.',
          'The Square is occupied by a black Pawn.',
          'The Square is occupied by a black Pawn.',
          'The Square is occupied by a black Pawn.',
          'The Square is occupied by a black Pawn.',
          'The Square is occupied by a black Pawn.'
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
          'The Square is occupied by a white Pawn.',
          'The Square is occupied by a white Pawn.',
          'The Square is occupied by a white Pawn.',
          'The Square is occupied by a white Pawn.',
          'The Square is occupied by a white Pawn.',
          'The Square is occupied by a white Pawn.',
          'The Square is occupied by a white Pawn.',
          'The Square is occupied by a white Pawn.'
        ],
        1 => [
          'The Square is occupied by a white Rook.',
          'The Square is occupied by a white Knight.',
          'The Square is occupied by a white Bishop.',
          'The Square is occupied by a white Queen.',
          'The Square is occupied by a white King.',
          'The Square is occupied by a white Bishop.',
          'The Square is occupied by a white Knight.',
          'The Square is occupied by a white Rook.'
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
