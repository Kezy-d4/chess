# frozen_string_literal: true

require_relative '../lib/square'

describe Square do
  describe '#update_piece' do
    subject(:square_empty) { described_class.new }

    it 'updates the square\'s piece' do
      new_piece = King.new(:white)
      square_empty.update_piece(new_piece)
      expect(square_empty.piece).to be(new_piece)
    end
  end

  describe '#remove_piece' do
    subject(:square_occupied) { described_class.new(King.new(:white)) }

    it 'removes the square\'s piece' do
      square_occupied.remove_piece
      expect(square_occupied.piece).to be_nil
    end
  end
end
