# frozen_string_literal: true

require_relative 'constants'

# Renders any chess position to console
# untested
class Display
  # @param position [Array<Array>] the chess position as a nested array
  def initialize(position)
    @position = position
    @active_square_color = :yellow
  end

  def render_board
    current_rank = Constants::NUMBER_OF_RANKS
    until current_rank < 1
      print "#{current_rank} "
      render_rank(current_rank)
      puts
      current_rank -= 1
    end
    file_markers = '  a b c d e f g h'
    puts file_markers
  end

  def update_position(new_position)
    @position = new_position
  end

  private

  def render_rank(rank_num) # rubocop:disable Metrics/MethodLength
    update_active_square_color(initial_square_color_for_current_rank(rank_num))
    rank_position = @position.reverse[rank_num - 1]
    rank_position.each do |element|
      if element.nil?
        render_empty_square
      elsif element_represents_a_piece?(element)
        unicode_icon = Constants::PIECE_UNICODE_ICON_MAP[element.to_sym]
        icon_color = element_represents_a_white_piece?(element) ? :white : :black
        render_occupied_square(unicode_icon, icon_color)
      end
      switch_active_square_color
    end
  end

  def render_empty_square
    square = '  '
    square_rgb_val = Constants::SQUARE_COLOR_RGB_MAP[@active_square_color]
    print "\e[48;2;#{square_rgb_val}m#{square}\e[0m"
  end

  def render_occupied_square(unicode_icon, icon_color)
    square = "#{unicode_icon} "
    square_rgb_val = Constants::SQUARE_COLOR_RGB_MAP[@active_square_color]
    icon_rgb_val = Constants::PLAYER_COLOR_RGB_MAP[icon_color]
    print "\e[48;2;#{square_rgb_val}m\e[38;2;#{icon_rgb_val}m#{square}\e[0m"
  end

  def update_active_square_color(new_color)
    @active_square_color = new_color
  end

  def switch_active_square_color
    if @active_square_color == :yellow
      update_active_square_color(:green)
    elsif @active_square_color == :green
      update_active_square_color(:yellow)
    end
  end

  def initial_square_color_for_current_rank(rank_num)
    if rank_num.even?
      update_active_square_color(:yellow)
    elsif rank_num.odd?
      update_active_square_color(:green)
    end
  end

  def element_represents_a_piece?(element)
    element.match?(/^[A-Z]+$/i)
  end

  def element_represents_a_white_piece?(element)
    element.match?(/^[A-Z]+$/)
  end

  def element_represents_a_black_piece?(element)
    element.match?(/^[a-z]+$/)
  end
end
