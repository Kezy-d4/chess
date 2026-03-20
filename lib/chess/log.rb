# frozen_string_literal: true

module Chess
  # Logs data about a chess position
  class Log
    # @param metadata [Hash{Symbol => Coord, Array<Coord>, nil}]
    # @param fen_history [Array<String>] the chronological history of FEN records
    def initialize(metadata = {}, fen_history = [])
      @metadata = metadata
      @fen_history = fen_history
    end

    def update_metadata(*associations)
      associations.each do |assoc|
        key = assoc[0]
        val = assoc[1]
        @metadata[key] = val
      end
    end

    def reset_metadata(*keys)
      keys.each { |key| @metadata[key] = nil if @metadata.include?(key) }
    end

    def push_fen(fen)
      @fen_history << fen
    end

    def dump
      { metadata: Marshal.load(Marshal.dump(@metadata)),
        fen_history: Marshal.load(Marshal.dump(@fen_history)) }
    end

    def threefold_repetition_rule_satisfied?
      hash = Hash.new(0)
      to_simplified_fen_history.each do |fen|
        hash[fen] += 1
        return true if hash[fen] == 3
      end
      false
    end

    def to_s
      <<~HEREDOC
        Metadata:
        #{to_metadata_s}
      HEREDOC
    end

    private

    def to_simplified_fen_history
      @fen_history.map do |fen|
        fen.split[0..3]
      end
    end

    def to_metadata_s
      arr = []
      @metadata.each do |key, val|
        arr << "#{key.to_s.capitalize.split('_').join(' ')}: "
        arr << "#{to_metadata_val_s(val)}\n"
      end
      arr.join
    end

    def to_metadata_val_s(metadata_val)
      case metadata_val
      when Array
        metadata_val.map(&:to_s)
      else
        metadata_val.to_s
      end
    end
  end
end
