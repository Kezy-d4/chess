# frozen_string_literal: true

module Chess
  # A chess position
  class Position # rubocop:disable Metrics/ClassLength
    # @param board [Board]
    # @param aux_pos_data [AuxPosData]
    # @param player_white [Player]
    # @param player_black [Player]
    # @param metadata [Hash{Symbol => String, Array<String>, nil}]
    #   the metadata detailing source, destination and other info
    def initialize(board, aux_pos_data, player_white, player_black, metadata)
      @board = board
      @aux_pos_data = aux_pos_data
      @player_white = player_white
      @player_black = player_black
      @metadata = metadata
    end

    class << self
      # @param player_white_name [String]
      # @param player_black_name [String]
      def new_default(player_white_name, player_black_name)
        fen = ChessConstants::FEN_DEFAULT
        f_p = FENParser.new(fen)
        board = Board.from_fen_parser(f_p)
        aux_pos_data = AuxPosData.from_fen_parser(f_p)
        player_white = Player.new(player_white_name, :white)
        player_black = Player.new(player_black_name, :black)
        metadata = new_default_metadata
        new(board, aux_pos_data, player_white, player_black, metadata)
      end

      def new_default_metadata
        { source: nil,
          controlled: nil }
      end
    end

    def to_fen
      "#{@board.to_partial_fen} #{@aux_pos_data.to_partial_fen}"
    end

    def move_from_source_to(coord_s)
      return unless @metadata[:source] && valid_move_from_source_to?(coord_s)

      piece = @board.square_at(@metadata[:source]).occupant
      @board.empty_at(@metadata[:source])
      @board.update_at(coord_s, piece)
      piece.increment_total_moves
    end

    def to_active_player
      if @aux_pos_data.white_has_the_move?
        @player_white
      elsif @aux_pos_data.black_has_the_move?
        @player_black
      end
    end

    def to_inactive_player
      if @aux_pos_data.white_has_the_move?
        @player_black
      elsif @aux_pos_data.black_has_the_move?
        @player_white
      end
    end

    def swap_active_player
      @aux_pos_data.swap_active_color
    end

    def to_player_associations(player)
      if player == @player_white
        @board.to_white_occupied_associations
      elsif player == @player_black
        @board.to_black_occupied_associations
      end
    end

    def select_source(coord_s)
      return unless valid_source?(coord_s)

      @metadata[:source] = coord_s
      update_controlled(source_to_adjacent_controlled_coords.values.flatten)
    end

    def deselect_source
      @metadata[:source] = nil
      reset_controlled
    end

    def update_controlled(coord_a)
      @metadata[:controlled] = coord_a
    end

    def reset_controlled
      @metadata[:controlled] = nil
    end

    def to_metadata
      @metadata.dup
    end

    def valid_source?(coord_s)
      to_player_associations(to_active_player).keys.map(&:to_s).include?(coord_s)
    end

    def valid_move_from_source_to?(coord_s)
      return false unless @metadata[:source]

      source_to_adjacent_controlled_coords.values.flatten.include?(coord_s)
    end

    def source_to_adjacent_controlled_coords
      return unless @metadata[:source]

      piece = @board.square_at(@metadata[:source]).occupant
      coord = @board.coord_at(@metadata[:source])
      movement = piece.to_adjacent_movement_coords(coord)
      controlled = movement.transform_values do |coord_a|
        coord_a.take_while { |coord_s| @board.square_at(coord_s).unoccupied? }
      end
      controlled.delete_empty_arr_vals
    end

    def to_s
      <<~HEREDOC
        Board:
        #{@board}
        AuxPosData:
        #{@aux_pos_data}
        Player playing white: #{@player_white}

        Player playing black: #{@player_black}

        Metadata:
        #{metadata_to_s}
      HEREDOC
    end

    def metadata_to_s
      arr = []
      @metadata.each do |key, val|
        arr << "#{key.capitalize}: "
        arr << "#{val}\n"
      end
      arr.join
    end
  end
end
