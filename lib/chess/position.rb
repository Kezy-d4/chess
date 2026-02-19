# frozen_string_literal: true

module Chess
  # A chess position
  class Position
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

    def valid_move?(source_coord, destination_coord)
      return false unless @board.occupied_at?(source_coord)

      controlled = to_adjacent_controlled_coords_from(source_coord)
      attacked = to_adjacent_attacked_coords_from(source_coord)
      controlled.values.flatten.include?(destination_coord) ||
        attacked.values.flatten.include?(destination_coord)
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
  end
end
