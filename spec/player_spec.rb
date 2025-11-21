# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  describe '#white?' do
    context 'when the player\'s color is white' do
      subject(:player_white) { described_class.new('Bob', :white, owned_pieces) }

      let(:owned_pieces) { double('owned_pieces') }

      it 'returns true' do
        result = player_white.white?
        expect(result).to be(true)
      end
    end

    context 'when the player\'s color is black' do
      subject(:player_black) { described_class.new('Bob', :black, owned_pieces) }

      let(:owned_pieces) { double('owned_pieces') }

      it 'returns false' do
        result = player_black.white?
        expect(result).to be(false)
      end
    end
  end

  describe '#black?' do
    context 'when the player\'s color is black' do
      subject(:player_black) { described_class.new('Bob', :black, owned_pieces) }

      let(:owned_pieces) { double('owned_pieces') }

      it 'returns true' do
        result = player_black.black?
        expect(result).to be(true)
      end
    end

    context 'when the player\'s color is white' do
      subject(:player_white) { described_class.new('Bob', :white, owned_pieces) }

      let(:owned_pieces) { double('owned_pieces') }

      it 'returns false' do
        result = player_white.black?
        expect(result).to be(false)
      end
    end
  end
end
