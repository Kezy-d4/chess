# frozen_string_literal: true

require_relative '../lib/fen_parser'

describe FenParser do
  describe '#parse_data_fields' do
    context 'when testing with the default fen record' do
      subject(:fen_parser_default) { described_class.new(Constants::DEFAULT_FEN) }

      let(:expected) do
        { piece_placement: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR',
          active_color: 'w',
          castling_availability: 'KQkq',
          en_passant_target: '-',
          half_move_clock: '0',
          full_move_number: '1' }
      end

      it 'returns a hash storing each data field' do
        result = fen_parser_default.parse_data_fields
        expect(result).to eq(expected)
      end
    end
  end

  describe '#parse_piece_placement' do
    context 'when testing with a simple endgame fen record' do
      subject(:fen_parser_simple) { described_class.new(simple_fen) }

      let(:simple_fen) { 'k7/8/8/8/8/8/8/7K w - - 0 65' }
      let(:expected) do
        { 8 => %w[k - - - - - - -],
          7 => %w[- - - - - - - -],
          6 => %w[- - - - - - - -],
          5 => %w[- - - - - - - -],
          4 => %w[- - - - - - - -],
          3 => %w[- - - - - - - -],
          2 => %w[- - - - - - - -],
          1 => %w[- - - - - - - K] }
      end

      it 'returns a hash storing the parsed piece placement data' do
        result = fen_parser_simple.parse_piece_placement
        expect(result).to eq(expected)
      end
    end
  end

  describe '#construct_piece_placement_with_squares' do
    context 'when testing with a simple endgame fen record' do
      subject(:fen_parser_simple) { described_class.new(simple_fen) }

      let(:simple_fen) { 'k7/8/8/8/8/8/8/7K w - - 0 65' }

      it 'returns a hash with the expected keys representing each rank' do
        result = fen_parser_simple.construct_piece_placement_with_squares
        keys = result.keys
        expect(keys).to eq([8, 7, 6, 5, 4, 3, 2, 1])
      end

      it 'returns a hash where each value is an array representing a rank\'s contents in order' do
        result = fen_parser_simple.construct_piece_placement_with_squares
        values = result.values
        expect(values).to all be_an(Array)
      end

      it 'the elements of each array are all square objects' do
        result = fen_parser_simple.construct_piece_placement_with_squares
        squares = result.values.flatten
        expect(squares).to all be_a(Square)
      end

      # rubocop:disable RSpec/ExampleLength
      it 'the piece at coordinates a8 is a king object' do
        rank_key = 8
        file_idx = 0
        result = fen_parser_simple.construct_piece_placement_with_squares
        square = result[rank_key][file_idx]
        piece = square.instance_variable_get(:@occupant)
        expect(piece).to be_a(King)
      end

      it 'the king at coordinates a8 has a black color' do
        rank_key = 8
        file_idx = 0
        result = fen_parser_simple.construct_piece_placement_with_squares
        square = result[rank_key][file_idx]
        piece = square.instance_variable_get(:@occupant)
        piece_color = piece.instance_variable_get(:@color)
        expect(piece_color).to eq(:black)
      end

      it 'the piece at coordinates h1 is a king object' do
        rank_key = 1
        file_idx = 7
        result = fen_parser_simple.construct_piece_placement_with_squares
        square = result[rank_key][file_idx]
        piece = square.instance_variable_get(:@occupant)
        expect(piece).to be_a(King)
      end

      it 'the king at coordinates h1 has a white color' do
        rank_key = 1
        file_idx = 7
        result = fen_parser_simple.construct_piece_placement_with_squares
        square = result[rank_key][file_idx]
        piece = square.instance_variable_get(:@occupant)
        piece_color = piece.instance_variable_get(:@color)
        expect(piece_color).to eq(:white)
      end

      it 'coordinates b8 through g1 are empty' do
        b8_idx = 1
        g1_idx = 62
        result = fen_parser_simple.construct_piece_placement_with_squares
        squares = result.values.flatten[b8_idx..g1_idx]
        occupants = squares.map { |square| square.instance_variable_get(:@occupant) }
        expect(occupants).to all be_nil
      end
      # rubocop:enable RSpec/ExampleLength
    end
  end
end
