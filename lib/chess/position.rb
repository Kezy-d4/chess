# frozen_string_literal: true

module Chess
  # A chess position
  class Position
    # @param board [Board]
    # @param aux_pos_data [AuxPosData]
    # @param player_white [Player] the Player playing white
    # @param player_black [Player] the Player playing black
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
      piece = @board.square_at(source_coord).occupant
      @board.empty_at(source_coord)
      @board.update_at(destination_coord, piece)
      piece.increment_total_moves
    end

    def check?; end

    # def clone; end

    def to_king_source(player)
      to_player_sources(player).find do |coord|
        @board.square_at(coord).occupant.instance_of?(King)
      end
    end

    def to_possible_destinations_from(coord)
      controlled_a = @board.to_adjacent_controlled_coords_from(coord)
      attacked_a = @board.to_adjacent_attacked_coords_from(coord)
      controlled_a + attacked_a
    end

    def to_active_player
      @aux_pos_data.white_has_the_move? ? @player_white : @player_black
    end

    def to_inactive_player
      @aux_pos_data.white_has_the_move? ? @player_black : @player_white
    end

    def swap_active_player
      @aux_pos_data.increment_full_move_number if to_active_player == @player_black
      @aux_pos_data.swap_active_color
    end

    def to_player_associations(player)
      @board.to_occupied_associations(player.color)
    end

    def to_player_sources(player)
      to_player_associations(player).keys
    end

    def to_player_squares(player)
      to_player_associations(player).values
    end

    def legal_source?(coord)
      to_player_sources(to_active_player).include?(coord)
    end

    def to_board_ranks
      @board.to_ranks
    end

    def dump_log
      @log.dump
    end

    def to_s
      <<~HEREDOC
        Board:
        #{@board}
        AuxPosData:
        #{@aux_pos_data}
        Player playing white: #{@player_white}#{"\n"}
        Player playing black: #{@player_black}#{"\n"}
        Log:
        #{@log}
      HEREDOC
    end
  end
end

# module Chess
#   # A chess position
#   class Position
#     using HashExtensions

#     # @param board [Board]
#     # @param aux_pos_data [AuxPosData]
#     # @param player_white [Player]
#     # @param player_black [Player]
#     # @param log [Log]
#     def initialize(board, aux_pos_data, player_white, player_black, log)
#       @board = board
#       @aux_pos_data = aux_pos_data
#       @player_white = player_white
#       @player_black = player_black
#       @log = log
#     end

#     class << self
#       # @param player_white_name [String]
#       # @param player_black_name [String]
#       def new_default(player_white_name, player_black_name)
#         fen = ChessConstants::FEN_DEFAULT
#         f_p = FENParser.new(fen)
#         board = Board.from_fen_parser(f_p)
#         aux_pos_data = AuxPosData.from_fen_parser(f_p)
#         player_white = Player.new(player_white_name, :white)
#         player_black = Player.new(player_black_name, :black)
#         log = Log.new({})
#         new(board, aux_pos_data, player_white, player_black, log)
#       end
#     end

#     def to_fen
#       "#{@board.to_partial_fen} #{@aux_pos_data.to_partial_fen}"
#     end

#     def move(source_coord, destination_coord)
#       return unless valid_move?(source_coord, destination_coord)

#       update_log_metadata_on_move(source_coord, destination_coord)
#       piece = @board.square_at(source_coord).occupant
#       @board.empty_at(source_coord)
#       @board.update_at(destination_coord, piece)
#       piece.increment_total_moves
#     end

#     def valid_move?(source_coord, destination_coord)
#       return false unless @board.occupied_at?(source_coord)

#       to_destinations_from(source_coord).include?(destination_coord)
#     end

#     def king_in_check?(player, other_player)
#       to_all_coords_attacked_by(other_player).include?(to_king_coord(player))
#     end

#     def to_adjacent_controlled_coords_from(coord)
#       return unless @board.occupied_at?(coord)

#       piece = @board.square_at(coord).occupant
#       movement = piece.to_adjacent_movement_coords(coord)
#       controlled = movement.transform_values do |coord_a|
#         coord_a.take_while { |adjacent_coord| @board.unoccupied_at?(adjacent_coord) }
#       end
#       controlled.delete_empty_arr_vals
#     end

#
#     def to_adjacent_attacked_coords_from(coord)
#       return unless @board.occupied_at?(coord)

#       piece = @board.square_at(coord).occupant
#       captures = piece.to_adjacent_capture_coords(coord)
#       attacked = captures.transform_values do |coord_a|
#         result = coord_a.find do |adjacent_coord|
#           next unless @board.square_at(adjacent_coord).occupied?

#           adjacent_occupant = @board.square_at(adjacent_coord).occupant
#           break if piece.color == adjacent_occupant.color

#           piece.color != adjacent_occupant.color
#         end
#         [result]
#       end
#       attacked.delete_empty_arr_vals
#     end

#     def to_active_player
#       if @aux_pos_data.white_has_the_move?
#         @player_white
#       elsif @aux_pos_data.black_has_the_move?
#         @player_black
#       end
#     end

#     def to_inactive_player
#       if @aux_pos_data.white_has_the_move?
#         @player_black
#       elsif @aux_pos_data.black_has_the_move?
#         @player_white
#       end
#     end

#     def swap_active_player
#       @aux_pos_data.swap_active_color
#     end

#     def dump_log
#       @log.dump
#     end

#     def legal_source?(coord)
#       to_active_player_sources.include?(coord)
#     end

#     def select_source(coord)
#       return unless legal_source?(coord)

#       controlled_a = to_adjacent_controlled_coords_from(coord).values.flatten
#       attacked_a = to_adjacent_attacked_coords_from(coord).values.flatten
#       @log.update_metadata(
#         [:current_source, coord],
#         [:currently_controlled, controlled_a],
#         [:currently_attacked, attacked_a]
#       )
#     end

#     def deselect_source
#       @log.reset_metadata(:current_source, :currently_controlled, :currently_attacked)
#     end

#     def source?
#       metadata = dump_log[:metadata]
#       !metadata[:current_source].nil? &&
#         !metadata[:currently_controlled].nil? &&
#         !metadata[:currently_attacked].nil?
#     end

#     def to_active_player_sources
#       to_player_associations(to_active_player).keys
#     end

#     def to_inactive_player_sources
#       to_player_associations(to_inactive_player).keys
#     end

#     def to_destinations_from(coord)
#       return unless @board.occupied_at?(coord)

#       controlled_a = to_adjacent_controlled_coords_from(coord).values.flatten
#       attacked_a = to_adjacent_attacked_coords_from(coord).values.flatten
#       controlled_a + attacked_a
#     end

#     def to_board_ranks
#       @board.to_ranks
#     end

#     def to_s
#       <<~HEREDOC
#         Board:
#         #{@board}
#         AuxPosData:
#         #{@aux_pos_data}
#         Player playing white: #{@player_white}

#         Player playing black: #{@player_black}

#         Log:
#         #{@log}
#       HEREDOC
#     end

#     private

#     def to_player_associations(player)
#       @board.to_occupied_associations(player.color)
#     end

#     def to_all_coords_attacked_by(player)
#       arr = []
#       to_player_associations(player).each_key do |coord|
#         arr << to_adjacent_attacked_coords_from(coord).values.flatten
#       end
#       arr.flatten
#     end

#     def to_king_coord(player)
#       assoc = to_player_associations(player).find do |_coord, square|
#         square.occupant.instance_of?(King) && square.occupant.color == player.color
#       end
#       assoc[0]
#     end

#
#     def update_log_metadata_on_move(source_coord, destination_coord)
#       if @board.occupied_at?(destination_coord)
#         captured_piece = @board.square_at(destination_coord).occupant
#         @log.update_metadata(
#           [:previous_capture, captured_piece],
#           [:previous_source, source_coord],
#           [:previous_destination, destination_coord]
#         )
#       elsif @board.unoccupied_at?(destination_coord)
#         @log.reset_metadata(:previous_capture)
#         @log.update_metadata(
#           [:previous_source, source_coord],
#           [:previous_destination, destination_coord]
#         )
#       end
#     end
#   end
# end
