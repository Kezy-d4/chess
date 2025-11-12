# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#from_fen_parser' do
    let(:fen_parser) { double('fen_parser') }

    before { allow(fen_parser).to receive(:construct_piece_placement_with_squares) }

    it 'sends the message to the fen parser to construct the piece placement with squares' do
      described_class.from_fen_parser(fen_parser)
      expect(fen_parser).to have_received(:construct_piece_placement_with_squares)
    end

    it 'returns a board object' do
      result = described_class.from_fen_parser(fen_parser)
      expect(result).to be_a(described_class)
    end
  end

  describe '#access_square' do
    context 'when accessing the square at coordinates a8' do
      subject(:board_a8) { described_class.new(squares) }

      let(:square) { double('square') }
      let(:square_a8) { double('square_a8') }
      let(:squares) do
        { 8 => [square_a8, square, square, square, square, square, square, square],
          7 => [square, square, square, square, square, square, square, square],
          6 => [square, square, square, square, square, square, square, square],
          5 => [square, square, square, square, square, square, square, square],
          4 => [square, square, square, square, square, square, square, square],
          3 => [square, square, square, square, square, square, square, square],
          2 => [square, square, square, square, square, square, square, square],
          1 => [square, square, square, square, square, square, square, square] }
      end

      it 'returns the square at coordinates a8' do
        algebraic_a8 = 'a8'
        result = board_a8.access_square(algebraic_a8)
        expect(result).to be(square_a8)
      end
    end
  end
end
