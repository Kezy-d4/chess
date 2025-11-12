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
end
