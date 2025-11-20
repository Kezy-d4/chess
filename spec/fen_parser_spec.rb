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

  describe '#construct_squares' do
    context 'when testing with a simple endgame fen record' do
      subject(:fen_parser_simple) { described_class.new(simple_fen) }

      let(:simple_fen) { 'k7/8/8/8/8/8/8/7K w - - 0 65' }

      it 'returns a hash containing the expected keys representing each rank' do
        result = fen_parser_simple.construct_squares
        keys = result.keys
        expect(keys).to eq([8, 7, 6, 5, 4, 3, 2, 1])
      end

      it 'returns a hash where each value is an array representing a rank\'s squares' do
        result = fen_parser_simple.construct_squares
        values = result.values
        expect(values).to all be_an(Array)
      end

      it 'each element within the arrays is a square object' do
        result = fen_parser_simple.construct_squares
        values = result.values
        elements = values.flatten
        expect(elements).to all be_a(Square)
      end

      # rubocop: disable RSpec/ExampleLength
      it 'the square at coordinates a8 has the expected coordinates' do
        result = fen_parser_simple.construct_squares
        values = result.values
        elements = values.flatten
        square_a8 = elements[0]
        square_a8_algebraic_coords = square_a8.instance_variable_get(:@algebraic_coords)
        expect(square_a8_algebraic_coords).to eq('a8')
      end

      it 'the square at coordinates a8 is occupied by a king object' do
        result = fen_parser_simple.construct_squares
        values = result.values
        elements = values.flatten
        square_a8 = elements[0]
        square_a8_occupant = square_a8.instance_variable_get(:@occupant)
        expect(square_a8_occupant).to be_a(King)
      end

      it 'the king at coordinates a8 has a black color' do
        result = fen_parser_simple.construct_squares
        values = result.values
        elements = values.flatten
        square_a8 = elements[0]
        king_a8 = square_a8.instance_variable_get(:@occupant)
        king_a8_color = king_a8.instance_variable_get(:@color)
        expect(king_a8_color).to eq(:black)
      end

      it 'the king at coordinates a8 has its total moves set to zero' do
        result = fen_parser_simple.construct_squares
        values = result.values
        elements = values.flatten
        square_a8 = elements[0]
        king_a8 = square_a8.instance_variable_get(:@occupant)
        king_a8_total_moves = king_a8.instance_variable_get(:@total_moves)
        expect(king_a8_total_moves).to eq(0)
      end

      it 'the king at coordinates a8 has the expected coordinates' do
        result = fen_parser_simple.construct_squares
        values = result.values
        elements = values.flatten
        square_a8 = elements[0]
        king_a8 = square_a8.instance_variable_get(:@occupant)
        king_a8_algebraic_coords = king_a8.instance_variable_get(:@algebraic_coords)
        expect(king_a8_algebraic_coords).to eq('a8')
      end

      it 'the square at coordinates h1 has the expected coordinates' do
        result = fen_parser_simple.construct_squares
        values = result.values
        elements = values.flatten
        square_h1 = elements[63]
        square_h1_algebraic_coords = square_h1.instance_variable_get(:@algebraic_coords)
        expect(square_h1_algebraic_coords).to eq('h1')
      end

      it 'the square at coordinates h1 is occupied by a king object' do
        result = fen_parser_simple.construct_squares
        values = result.values
        elements = values.flatten
        square_h1 = elements[63]
        square_h1_occupant = square_h1.instance_variable_get(:@occupant)
        expect(square_h1_occupant).to be_a(King)
      end

      it 'the king at coordinates h1 has a white color' do
        result = fen_parser_simple.construct_squares
        values = result.values
        elements = values.flatten
        square_h1 = elements[63]
        king_h1 = square_h1.instance_variable_get(:@occupant)
        king_h1_color = king_h1.instance_variable_get(:@color)
        expect(king_h1_color).to eq(:white)
      end

      it 'the king at coordinates h1 has their total moves set to zero' do
        result = fen_parser_simple.construct_squares
        values = result.values
        elements = values.flatten
        square_h1 = elements[63]
        king_h1 = square_h1.instance_variable_get(:@occupant)
        king_h1_total_moves = king_h1.instance_variable_get(:@total_moves)
        expect(king_h1_total_moves).to eq(0)
      end

      it 'the king at coordinates h1 has the expected coordinates' do
        result = fen_parser_simple.construct_squares
        values = result.values
        elements = values.flatten
        square_h1 = elements[63]
        king_h1 = square_h1.instance_variable_get(:@occupant)
        king_h1_algebraic_coords = king_h1.instance_variable_get(:@algebraic_coords)
        expect(king_h1_algebraic_coords).to eq('h1')
      end

      it 'the remaining squares at coordinates b8 through g1 are all empty' do
        result = fen_parser_simple.construct_squares
        values = result.values
        elements = values.flatten
        b8_through_g1 = elements[1..62]
        b8_through_g1_occupants = b8_through_g1.map do |square|
          square.instance_variable_get(:@occupant)
        end
        expect(b8_through_g1_occupants).to all be_nil
      end
      # rubocop: enable all
    end
  end
end
