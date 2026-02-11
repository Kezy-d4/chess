# frozen_string_literal: true

module Chess
  # Displays a chess board on the command line
  class Display
    COLOR_RGB_MAP = {
      white: '255;255;255',
      black: '0;0;0',
      green: '119;162;109',
      yellow: '200;194;100',
      orange: '179;89;45'
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

    # @param board [Board]
    def initialize(board)
      @board = board
    end

    def render_board(metadata)
      ChessConstants::BOARD_RANK_MARKERS.each do |rank_i|
        render_rank(rank_i, metadata)
        puts
      end
      puts ' a  b  c  d  e  f  g  h'
    end

    private

    def render_rank(rank_i, metadata)
      print "#{rank_i} "
      bg_color = rank_i.even? ? :yellow : :green
      file_idx = 0
      @board.to_ranks[rank_i].each do |square|
        coord_s = "#{Chess::ChessConstants::BOARD_FILE_MARKERS[file_idx]}#{rank_i}"
        render_square(square, coord_s, bg_color, metadata)
        bg_color = swap_bg_color(bg_color)
        file_idx += 1
      end
    end

    def render_square(square, coord_s, bg_color, metadata)
      if source_square?(coord_s, metadata)
        render_occupied_square(square.occupant, :orange)
      elsif square_controlled?(coord_s, metadata)
        render_controlled_square(:orange, bg_color)
      elsif square.occupied?
        render_occupied_square(square.occupant, bg_color)
      elsif square.unoccupied?
        render_unoccupied_square(bg_color)
      end
    end

    def render_occupied_square(occupant, bg_color)
      fg_rgb_val = COLOR_RGB_MAP[occupant.color]
      bg_rgb_val = COLOR_RGB_MAP[bg_color]
      occupant_icon = PIECE_ICON_MAP[occupant.to_class_s.downcase.to_sym]
      square = " #{occupant_icon} "
      print "\e[48;2;#{bg_rgb_val}m\e[38;2;#{fg_rgb_val}m#{square}\e[0m"
    end

    def render_unoccupied_square(bg_color)
      rgb_val = COLOR_RGB_MAP[bg_color]
      square = '   '
      print "\e[48;2;#{rgb_val}m#{square}\e[0m"
    end

    def render_controlled_square(fg_color, bg_color)
      fg_rgb_val = COLOR_RGB_MAP[fg_color]
      bg_rgb_val = COLOR_RGB_MAP[bg_color]
      square = " #{CONTROLLED_INDICATOR} "
      print "\e[48;2;#{bg_rgb_val}m\e[38;2;#{fg_rgb_val}m#{square}\e[0m"
    end

    def swap_bg_color(bg_color)
      if bg_color == :yellow
        :green
      elsif bg_color == :green
        :yellow
      end
    end

    def square_controlled?(coord_s, metadata)
      metadata[:controlled].include?(coord_s)
    end

    def source_square?(coord_s, metadata)
      metadata[:source] == coord_s
    end
  end
end
