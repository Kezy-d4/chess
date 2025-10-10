# frozen_string_literal: true

require_relative '../lib/fen_deserialization'

describe FenDeserialization do
  let(:dummy_class) { Class.new { extend FenDeserialization } }

  describe '#fen_to_instantiated_algebraic' do
    context 'when the FEN record represents the initial chess position' do
      subject(:initial_fen) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }

      let(:expected_algebraic_keys) do
        %i[a8 b8 c8 d8 e8 f8 g8 h8
           a7 b7 c7 d7 e7 f7 g7 h7
           a6 b6 c6 d6 e6 f6 g6 h6
           a5 b5 c5 d5 e5 f5 g5 h5
           a4 b4 c4 d4 e4 f4 g4 h4
           a3 b3 c3 d3 e3 f3 g3 h3
           a2 b2 c2 d2 e2 f2 g2 h2
           a1 b1 c1 d1 e1 f1 g1 h1]
      end

      it 'returns a hash' do
        result = dummy_class.fen_to_instantiated_algebraic(initial_fen)
        expect(result).to be_a(Hash)
      end

      it 'returns a hash with the expected algebraic keys' do
        result = dummy_class.fen_to_instantiated_algebraic(initial_fen)
        expect(result.keys).to eq(expected_algebraic_keys)
      end

      it 'returns a hash where each value is a square object' do
        result = dummy_class.fen_to_instantiated_algebraic(initial_fen)
        expect(result.values).to all be_a(Square)
      end

      it 'the occupant pieces of the eighth rank are all black' do
        result = dummy_class.fen_to_instantiated_algebraic(initial_fen)
        eighth_rank_squares = [result[:a8], result[:b8], result[:c8], result[:d8],
                               result[:e8], result[:f8], result[:g8], result[:h8]]
        eighth_rank_colors = eighth_rank_squares.map { |square| square.occupant.color }
        expect(eighth_rank_colors).to all eq(:black)
      end

      it 'the occupant pieces of the seventh rank are all black' do
        result = dummy_class.fen_to_instantiated_algebraic(initial_fen)
        seventh_rank_squares = [result[:a7], result[:b7], result[:c7], result[:d7],
                                result[:e7], result[:f7], result[:g7], result[:h7]]
        seventh_rank_colors = seventh_rank_squares.map { |square| square.occupant.color }
        expect(seventh_rank_colors).to all eq(:black)
      end

      it 'the occupant pieces of the second rank are all white' do
        result = dummy_class.fen_to_instantiated_algebraic(initial_fen)
        second_rank_squares = [result[:a2], result[:b2], result[:c2], result[:d2],
                               result[:e2], result[:f2], result[:g2], result[:h2]]
        second_rank_colors = second_rank_squares.map { |square| square.occupant.color }
        expect(second_rank_colors).to all eq(:white)
      end

      it 'the occupant pieces of the first rank are all white' do
        result = dummy_class.fen_to_instantiated_algebraic(initial_fen)
        first_rank_squares = [result[:a1], result[:b1], result[:c1], result[:d1],
                              result[:e1], result[:f1], result[:g1], result[:h1]]
        first_rank_colors = first_rank_squares.map { |square| square.occupant.color }
        expect(first_rank_colors).to all eq(:white)
      end

      it 'the squares of ranks three through six are all empty' do
        result = dummy_class.fen_to_instantiated_algebraic(initial_fen)
        empty_rank_keys = result.keys.select { |algebraic_coords| algebraic_coords.to_s[-1].to_i.between?(3, 6) }
        empty_rank_occupants = empty_rank_keys.map { |algebraic_coords| result[algebraic_coords].occupant }
        expect(empty_rank_occupants).to all be_nil
      end

      it 'the occupant pieces of the seventh rank are all pawn objects' do
        result = dummy_class.fen_to_instantiated_algebraic(initial_fen)
        seventh_rank_squares = [result[:a7], result[:b7], result[:c7], result[:d7],
                                result[:e7], result[:f7], result[:g7], result[:h7]]
        seventh_rank_occupants = seventh_rank_squares.map(&:occupant)
        expect(seventh_rank_occupants).to all be_a(Pawn)
      end

      it 'the occupant pieces of the second rank are all pawn objects' do
        result = dummy_class.fen_to_instantiated_algebraic(initial_fen)
        second_rank_squares = [result[:a2], result[:b2], result[:c2], result[:d2],
                               result[:e2], result[:f2], result[:g2], result[:h2]]
        second_rank_occupants = second_rank_squares.map(&:occupant)
        expect(second_rank_occupants).to all be_a(Pawn)
      end

      it 'the occupant pieces of squares a8, a1, h8 and h1 are all rook objects' do
        result = dummy_class.fen_to_instantiated_algebraic(initial_fen)
        rook_occupants = [result[:a8].occupant, result[:a1].occupant,
                          result[:h8].occupant, result[:h1].occupant]
        expect(rook_occupants).to all be_a(Rook)
      end

      it 'the occupant pieces of squares b8, b1, g8 and g1 are all knight objects' do
        result = dummy_class.fen_to_instantiated_algebraic(initial_fen)
        knight_occupants = [result[:b8].occupant, result[:b1].occupant,
                            result[:g8].occupant, result[:g1].occupant]
        expect(knight_occupants).to all be_a(Knight)
      end

      it 'the occupant pieces of squares c8, c1, f8, and f1 are all bishop objects' do
        result = dummy_class.fen_to_instantiated_algebraic(initial_fen)
        bishop_occupants = [result[:c8].occupant, result[:c1].occupant,
                            result[:f8].occupant, result[:f1].occupant]
        expect(bishop_occupants).to all be_a(Bishop)
      end

      it 'the occupant pieces of squares d8 and d1 are both queen objects' do
        result = dummy_class.fen_to_instantiated_algebraic(initial_fen)
        queen_occupants = [result[:d8].occupant, result[:d1].occupant]
        expect(queen_occupants).to all be_a(Queen)
      end

      it 'the occupant pieces of squares e8 and e1 are both king objects' do
        result = dummy_class.fen_to_instantiated_algebraic(initial_fen)
        king_occupants = [result[:e8].occupant, result[:e1].occupant]
        expect(king_occupants).to all be_a(King)
      end
    end
  end
end
