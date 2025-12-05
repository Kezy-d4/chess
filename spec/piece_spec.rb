# frozen_string_literal: true

require_relative '../lib/piece'

describe Piece do
  describe '#to_s' do
    subject(:piece) { described_class.new('a8', :white) }

    let(:expected) do
      '<Piece>: [@algebraic_coords: a8, @color: white, @total_moves: 0]'
    end

    it 'returns a string describing the state of the piece' do
      result = piece.to_s
      expect(result).to eq(expected)
    end
  end
end
