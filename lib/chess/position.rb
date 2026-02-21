# frozen_string_literal: true

module Chess
  # A chess position
  class Position # rubocop:disable Metrics/ClassLength
    # @param board [Board]
    # @param aux_pos_data [AuxPosData]
    # @param player_white [Player]
    # @param player_black [Player]
    # @param log [Log]
    def initialize(board, aux_pos_data, player_white, player_black, log)
      @board = board
      @aux_pos_data = aux_pos_data
      @player_white = player_white
      @player_black = player_black
      @log = log
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
        log = Log.new({})
        new(board, aux_pos_data, player_white, player_black, log)
      end
    end

    def to_fen
      "#{@board.to_partial_fen} #{@aux_pos_data.to_partial_fen}"
    end

    def move(source_coord, destination_coord)
      return unless valid_move?(source_coord, destination_coord)

      update_log_metadata_on_move(source_coord, destination_coord)
      piece = @board.square_at(source_coord).occupant
      @board.empty_at(source_coord)
      @board.update_at(destination_coord, piece)
      piece.increment_total_moves
    end

    def valid_move?(source_coord, destination_coord)
      return false unless @board.occupied_at?(source_coord)

      controlled_a = to_adjacent_controlled_coords_from(source_coord).values.flatten
      attacked_a = to_adjacent_attacked_coords_from(source_coord).values.flatten
      controlled_a.include?(destination_coord) || attacked_a.include?(destination_coord)
    end

    def valid_source?(coord)
      to_player_associations(to_active_player).key?(coord)
    end

    def to_adjacent_controlled_coords_from(coord)
      return unless @board.occupied_at?(coord)

      piece = @board.square_at(coord).occupant
      movement = piece.to_adjacent_movement_coords(coord)
      controlled = movement.transform_values do |coord_a|
        coord_a.take_while { |adjacent_coord| @board.unoccupied_at?(adjacent_coord) }
      end
      controlled.delete_empty_arr_vals
    end

    # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    def to_adjacent_attacked_coords_from(coord)
      return unless @board.occupied_at?(coord)

      piece = @board.square_at(coord).occupant
      movement = piece.to_adjacent_movement_coords(coord)
      attacked = movement.transform_values do |coord_a|
        result = coord_a.find do |adjacent_coord|
          next unless @board.square_at(adjacent_coord).occupied?

          adjacent_occupant = @board.square_at(adjacent_coord).occupant
          break if piece.color == adjacent_occupant.color

          piece.color != adjacent_occupant.color
        end
        [result]
      end
      attacked.delete_empty_arr_vals
    end
    # rubocop:enable all

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

    def dump_log
      @log.dump
    end

    def select_source(coord)
      return unless valid_source?(coord)

      controlled_a = to_adjacent_controlled_coords_from(coord).values.flatten
      attacked_a = to_adjacent_attacked_coords_from(coord).values.flatten
      @log.update_metadata(
        [:current_source, coord],
        [:currently_controlled, controlled_a],
        [:currently_attacked, attacked_a]
      )
    end

    def deselect_source
      @log.reset_metadata(:current_source, :currently_controlled, :currently_attacked)
    end

    def to_s
      <<~HEREDOC
        Board:
        #{@board}
        AuxPosData:
        #{@aux_pos_data}
        Player playing white: #{@player_white}

        Player playing black: #{@player_black}

        Log:
        #{@log}
      HEREDOC
    end

    private

    def to_player_associations(player)
      if player == @player_white
        @board.to_white_occupied_associations
      elsif player == @player_black
        @board.to_black_occupied_associations
      end
    end

    # rubocop:disable Metrics/MethodLength
    def update_log_metadata_on_move(source_coord, destination_coord)
      if @board.occupied_at?(destination_coord)
        captured_piece = @board.square_at(destination_coord).occupant
        @log.update_metadata(
          [:previous_capture, captured_piece],
          [:previous_source, source_coord],
          [:previous_destination, destination_coord]
        )
      elsif @board.unoccupied_at?(destination_coord)
        @log.reset_metadata(:previous_capture)
        @log.update_metadata(
          [:previous_source, source_coord],
          [:previous_destination, destination_coord]
        )
      end
    end
    # rubocop:enable all
  end
end
