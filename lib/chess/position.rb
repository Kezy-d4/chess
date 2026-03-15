# frozen_string_literal: true

module Chess
  # A chess position
  class Position # rubocop:disable Metrics/ClassLength
    using HashExtensions

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
      # @param fen_parser [FENParser]
      # @param player_white_name [String]
      # @param player_black_name [String]
      # @param log [Log]
      def from_fen_parser(
        fen_parser,
        player_white_name = 'w',
        player_black_name = 'b',
        log = Log.new({})
      )
        board = Board.from_fen_parser(fen_parser)
        aux_pos_data = AuxPosData.from_fen_parser(fen_parser)
        player_white = Player.new(player_white_name, :white)
        player_black = Player.new(player_black_name, :black)
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
    end

    def check?
      to_attacked_destinations_by(to_inactive_player).include?(to_king_source(to_active_player))
    end

    def checkmate?
      check? && !any_legal_moves_available_to?(to_active_player)
    end

    def stalemate?
      !check? && !any_legal_moves_available_to?(to_active_player)
    end

    def draw_by_fifty_move_rule_claimable?
      @aux_pos_data.fifty_move_rule_satisfied?
    end

    def draw_by_seventy_five_move_rule?
      @aux_pos_data.seventy_five_move_rule_satisfied?
    end

    def over?
      checkmate? || stalemate? || draw_by_seventy_five_move_rule?
    end

    def legal_move?(source_coord, destination_coord)
      legal_source?(source_coord) && to_legal_destinations_from(source_coord).include?(destination_coord)
    end

    def to_legal_destinations_from(coord)
      to_legal_controlled_destinations_from(coord) + to_legal_attacked_destinations_from(coord)
    end

    def legal_source?(coord)
      to_player_sources(to_active_player).include?(coord)
    end

    def select_source(coord)
      @log.update_metadata(
        [:current_source, coord],
        [:currently_controlled, to_legal_controlled_destinations_from(coord)],
        [:currently_attacked, to_legal_attacked_destinations_from(coord)]
      )
    end

    def deselect_source
      @log.reset_metadata(:current_source, :currently_controlled, :currently_attacked)
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
      update_metadata_after_player_swap
    end

    def to_player_sources(player)
      to_player_associations(player).keys
    end

    def to_board_ranks
      @board.to_ranks
    end

    def dump_log
      @log.dump
    end

    def to_s
      <<~HEREDOC
        FEN: #{to_fen}
        Player playing white: #{@player_white}
        Player playing black: #{@player_black}
        Log:
        #{@log}
      HEREDOC
    end

    private

    def any_legal_moves_available_to?(player)
      to_legal_moves_available_to(player).any?
    end

    def to_legal_moves_available_to(player)
      hash = to_player_sources(player).each_with_object({}) do |coord, hash|
        hash[coord] = to_legal_destinations_from(coord)
      end
      hash.delete_empty_arr_vals
    end

    def move_would_leave_active_player_in_check?(source_coord, destination_coord)
      clone = self.clone
      clone.move(source_coord, destination_coord)
      clone.check?
    end

    def to_legal_controlled_destinations_from(source_coord)
      return [] unless legal_source?(source_coord)

      to_controlled_destinations_from(source_coord).reject do |destination_coord|
        destination_coord == to_king_source(to_inactive_player) ||
          move_would_leave_active_player_in_check?(source_coord, destination_coord)
      end
    end

    def to_legal_attacked_destinations_from(source_coord)
      return [] unless legal_source?(source_coord)

      to_attacked_destinations_from(source_coord).reject do |destination_coord|
        destination_coord == to_king_source(to_inactive_player) ||
          move_would_leave_active_player_in_check?(source_coord, destination_coord)
      end
    end

    def to_controlled_destinations_from(coord)
      @board.to_adjacent_controlled_coords_from(coord).values.flatten
    end

    def to_attacked_destinations_from(coord)
      @board.to_adjacent_attacked_coords_from(coord).values.flatten
    end

    def to_possible_destinations_from(coord)
      to_controlled_destinations_from(coord) + to_attacked_destinations_from(coord)
    end

    def to_attacked_destinations_by(player)
      arr = to_player_sources(player).each_with_object([]) do |coord, arr|
        arr << to_attacked_destinations_from(coord)
      end
      arr.flatten
    end

    def to_king_source(player)
      to_player_sources(player).find do |coord|
        @board.square_at(coord).occupant.instance_of?(King)
      end
    end

    def to_player_associations(player)
      @board.to_occupied_associations(player.color)
    end

    def clone
      Marshal.load(Marshal.dump(self))
    end

    # rubocop:disable Metrics/MethodLength
    def update_metadata_before_move(source_coord, destination_coord)
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
    # rubocop: enable all

    def update_metadata_after_player_swap
      if check?
        @log.update_metadata([:checked_king, to_king_source(to_active_player)])
      elsif !check?
        @log.reset_metadata(:checked_king)
      end
    end
  end
end
