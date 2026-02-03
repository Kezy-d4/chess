# frozen_string_literal: true

describe Chess::Player do
  describe '#white?' do
    context 'when white' do
      subject(:player_white) { described_class.new('Player', :white) }

      it 'returns true' do
        result = player_white.white?
        expect(result).to be(true)
      end
    end

    context 'when black' do
      subject(:player_black) { described_class.new('Player', :black) }

      it 'returns false' do
        result = player_black.white?
        expect(result).to be(false)
      end
    end
  end

  describe '#black?' do
    context 'when black' do
      subject(:player_black) { described_class.new('Player', :black) }

      it 'returns true' do
        result = player_black.black?
        expect(result).to be(true)
      end
    end

    context 'when white' do
      subject(:player_white) { described_class.new('Player', :white) }

      it 'returns false' do
        result = player_white.black?
        expect(result).to be(false)
      end
    end
  end

  describe '#to_s' do
    subject(:player) { described_class.new('Player', :white) }

    it 'returns a string describing the state' do
      result = player.to_s
      expect(result).to eq('Player(white)')
    end
  end
end
