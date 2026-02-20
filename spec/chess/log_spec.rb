# frozen_string_literal: true

describe Chess::Log do
  describe '#update_metadata' do
    context 'when setting new key(s)' do
      subject(:log_empty) { described_class.new({}) }

      let(:associations) do
        [
          [:current_source, current_source_val],
          [:previous_source, previous_source_val]
        ]
      end
      let(:current_source_val) { double('Coord') }
      let(:previous_source_val) { double('Coord') }

      # rubocop:disable RSpec/RepeatedDescription
      it 'sets the given key(s) to the given values' do
        log_empty.update_metadata(*associations)
        expect(log_empty.instance_variable_get(:@metadata)[:current_source]).to be(current_source_val)
      end

      it 'sets the given key(s) to the given values' do
        log_empty.update_metadata(*associations)
        expect(log_empty.instance_variable_get(:@metadata)[:previous_source]).to be(previous_source_val)
      end
      # rubocop:enable all
    end

    context 'when overwriting existing key(s)' do
      subject(:log_populated) do
        log = described_class.new({})
        log.update_metadata(
          [:current_source, current_source_val],
          [:previous_source, previous_source_val]
        )
        log
      end

      let(:associations) do
        [
          [:current_source, new_current_source_val],
          [:previous_source, new_previous_source_val]
        ]
      end
      let(:current_source_val) { double('Coord') }
      let(:previous_source_val) { double('Coord') }
      let(:new_current_source_val) { double('Coord') }
      let(:new_previous_source_val) { double('Coord') }

      # rubocop:disable RSpec/RepeatedDescription
      it 'overwrites the given key(s) with the given values' do
        expect { log_populated.update_metadata(*associations) }.to change \
          { log_populated.instance_variable_get(:@metadata)[:current_source] }
          .from(current_source_val).to(new_current_source_val)
      end

      it 'overwrites the given key(s) with the given values' do
        expect { log_populated.update_metadata(*associations) }.to change \
          { log_populated.instance_variable_get(:@metadata)[:previous_source] }
          .from(previous_source_val).to(new_previous_source_val)
      end
      # rubocop: enable all
    end
  end

  describe '#reset_metadata' do
    subject(:log_populated) do
      log = described_class.new({})
      log.update_metadata(
        [:current_source, current_source_val],
        [:previous_source, previous_source_val]
      )
      log
    end

    let(:current_source_val) { double('Coord') }
    let(:previous_source_val) { double('Coord') }

    context 'when passed non-existent key(s)' do
      let(:keys) { %i[currently_controlled currently_attacked] }

      it 'does nothing' do
        expect { log_populated.reset_metadata(*keys) }.not_to(change \
          { log_populated.instance_variable_get(:@metadata) })
      end
    end

    context 'when passed existing key(s)' do
      let(:keys) { %i[current_source previous_source] }

      # rubocop:disable RSpec/RepeatedDescription
      it 'sets the given key(s) to nil' do
        expect { log_populated.reset_metadata(*keys) }.to change \
          { log_populated.instance_variable_get(:@metadata)[:current_source] }
          .from(current_source_val).to(nil)
      end

      it 'sets the given key(s) to nil' do
        expect { log_populated.reset_metadata(*keys) }.to change \
          { log_populated.instance_variable_get(:@metadata)[:previous_source] }
          .from(previous_source_val).to(nil)
      end
      # rubocop: enable all
    end
  end

  describe '#dump' do
    subject(:log) { described_class.new({}) }

    let(:log_metadata) { log.instance_variable_get(:@metadata) }

    # rubocop:disable RSpec/MultipleExpectations
    it 'returns a hash containing the duplicated metadata' do
      result = log.dump
      metadata = result[:metadata]
      expect(metadata).to eq(log_metadata)
      expect(metadata).not_to equal(log_metadata)
    end
    # rubocop:enable all
  end

  describe '#to_s' do
    context 'when populated' do
      subject(:log_populated) do
        metadata = {
          current_source: Chess::Coord.from_s('e4'),
          currently_controlled: [Chess::Coord.from_s('e3'), Chess::Coord.from_s('e2')],
          currently_attacked: [Chess::Coord.from_s('e5'), Chess::Coord.from_s('e6')],
          previous_source: Chess::Coord.from_s('a8'),
          previous_destination: Chess::Coord.from_s('b6'),
          previous_capture: Chess::Pawn.new(:black)
        }
        described_class.new(metadata)
      end

      let(:expected) do
        <<~HEREDOC
          Metadata:
          Current source: e4
          Currently controlled: ["e3", "e2"]
          Currently attacked: ["e5", "e6"]
          Previous source: a8
          Previous destination: b6
          Previous capture: The Pawn is black and has not moved.

        HEREDOC
      end

      it 'returns the expected string' do
        result = log_populated.to_s
        expect(result).to eq(expected)
      end
    end

    context 'when mixed' do
      subject(:log_mixed) do
        metadata = {
          currently_attacked: [Chess::Coord.from_s('e5'), Chess::Coord.from_s('e6')],
          previous_source: nil
        }
        described_class.new(metadata)
      end

      let(:expected) do
        <<~HEREDOC
          Metadata:
          Currently attacked: ["e5", "e6"]
          Previous source:#{' '}

        HEREDOC
      end

      it 'returns the expected string' do
        result = log_mixed.to_s
        expect(result).to eq(expected)
      end
    end

    context 'when empty' do
      subject(:log_empty) { described_class.new({}) }

      let(:expected) do
        <<~HEREDOC
          Metadata:

        HEREDOC
      end

      it 'returns the expected string' do
        result = log_empty.to_s
        expect(result).to eq(expected)
      end
    end
  end
end
