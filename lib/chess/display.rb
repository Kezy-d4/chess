# frozen_string_literal: true

module Chess
  # Displays a chess board on the command line
  class Display # rubocop:disable Metrics/ClassLength
    using ObjectExtensions

    COLOR_RGB_MAP = {
      white: '255;255;255',
      black: '0;0;0',
      green: '119;162;109',
      yellow: '200;194;100',
      lighter_orange: '170;82;48',
      darker_orange: '130;68;43',
      lighter_olive: '150;144;49',
      darker_olive: '130;125;53',
      red: '168;50;50'
    }.freeze

    PIECE_ICON_MAP = {
      king: "\u{265A}",
      queen: "\u{265B}",
      rook: "\u{265C}",
      bishop: "\u{265D}",
      knight: "\u{265E}",
      pawn: "\u{2659}"
    }.freeze

    CONTROLLED_INDICATOR = "\u{25CF}"

    BOARD_FILE_MARKERS = '   a  b  c  d  e  f  g  h'

    def initialize
      @current_bg_color = :yellow
    end

    def render_board(board_ranks, metadata)
      ChessConstants::BOARD_RANK_MARKERS.each do |rank_i|
        render_rank(board_ranks[rank_i], rank_i, metadata)
        puts
      end
      puts BOARD_FILE_MARKERS
    end

    private

    def render_rank(rank, rank_i, metadata)
      print "#{rank_i} "
      rank_i.even? ? update_current_bg_color(:yellow) : update_current_bg_color(:green)
      file_idx = 0
      rank.each do |square|
        coord_s = "#{ChessConstants::BOARD_FILE_MARKERS[file_idx]}#{rank_i}"
        coord = Chess::Coord.from_s(coord_s)
        render_square(square, coord, @current_bg_color, metadata)
        swap_current_bg_color
        file_idx += 1
      end
    end

    # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    def render_square(square, coord, bg_color, metadata)
      if metadata[:current_source] == coord
        render_source_square(square.occupant)
      elsif metadata[:currently_controlled]&.include?(coord)
        render_controlled_square(bg_color)
      elsif metadata[:currently_attacked]&.include?(coord)
        render_attacked_square(square.occupant)
      elsif metadata[:previous_source] == coord
        render_previous_source_square
      elsif metadata[:previous_destination] == coord
        render_previous_destination_square(square.occupant)
      elsif square.occupied?
        render_occupied_square(square.occupant, bg_color)
      elsif square.unoccupied?
        render_unoccupied_square(bg_color)
      end
    end
    # rubocop:enable all

    def render_occupied_square(occupant, bg_color)
      fg_rgb_val = COLOR_RGB_MAP[occupant.color]
      bg_rgb_val = COLOR_RGB_MAP[bg_color]
      occupant_icon = PIECE_ICON_MAP[occupant.to_class_s.downcase.to_sym]
      square = " #{occupant_icon} "
      print "\e[48;2;#{bg_rgb_val}m\e[38;2;#{fg_rgb_val}m#{square}\e[0m"
    end

    def render_unoccupied_square(bg_color)
      bg_rgb_val = COLOR_RGB_MAP[bg_color]
      square = '   '
      print "\e[48;2;#{bg_rgb_val}m#{square}\e[0m"
    end

    def render_controlled_square(bg_color)
      fg_rgb_val = COLOR_RGB_MAP[:lighter_orange]
      bg_rgb_val = COLOR_RGB_MAP[bg_color]
      square = " #{CONTROLLED_INDICATOR} "
      print "\e[48;2;#{bg_rgb_val}m\e[38;2;#{fg_rgb_val}m#{square}\e[0m"
    end

    def render_source_square(occupant)
      render_occupied_square(occupant, :lighter_orange)
    end

    def render_attacked_square(occupant)
      render_occupied_square(occupant, :darker_orange)
    end

    def render_previous_source_square
      render_unoccupied_square(:lighter_olive)
    end

    def render_previous_destination_square(occupant)
      render_occupied_square(occupant, :darker_olive)
    end

    def update_current_bg_color(color)
      return unless %i[yellow green].include?(color)

      @current_bg_color = color
    end

    def swap_current_bg_color
      if @current_bg_color == :yellow
        @current_bg_color = :green
      elsif @current_bg_color == :green
        @current_bg_color = :yellow
      end
    end
  end
end
