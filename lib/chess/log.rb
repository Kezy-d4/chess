# frozen_string_literal: true

module Chess
  # Logs data about a chess position
  class Log
    # @param metadata [Hash{Symbol => Coord, Array<Coord>, Piece, nil}]
    def initialize(metadata)
      @metadata = metadata
    end

    def update_metadata(key, val)
      @metadata[key] = val
    end

    def reset_metadata(*keys)
      keys.each { |key| @metadata[key] = nil if @metadata.include?(key) }
    end

    def dump
      { metadata: @metadata.dup }
    end

    def to_s
      <<~HEREDOC
        Metadata:
        #{to_metadata_s}
      HEREDOC
    end

    private

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
