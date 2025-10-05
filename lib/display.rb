# frozen_string_literal: true

require_relative 'constants'
require_relative 'position'

# Renders board elements to console
class Display
  def initialize(position)
    @position = position
    @active_square_color = :yellow
  end

  def render_board
    Constants::BOARD_RANKS.to_a.reverse_each do |rank|
      print "#{rank} "
      render_rank(rank)
      puts
    end
    print '   '
    Constants::BOARD_FILES.each { |file| print "#{file}  " }
    puts
  end

  private

  def render_rank(rank)
    update_active_square_color(initial_square_color_for_rank(rank))
    rank_keys(rank).each do |algebraic_id|
      square = @position.access_square(algebraic_id)
      if square.empty?
        render_empty_square
      elsif square.occupied?
        render_occupied_square(square)
      end
      switch_active_square_color
    end
  end

  def initial_square_color_for_rank(rank)
    if rank.even?
      :yellow
    elsif rank.odd?
      :green
    end
  end

  def rank_keys(rank)
    Constants::BOARD_FILES.each_with_object([]) do |file, arr|
      arr << :"#{file}#{rank}"
    end
  end

  def render_empty_square
    ansi = "\e[48;2;#{square_rgb_val}m#{empty_square}\e[0m"
    print ansi
  end

  def render_occupied_square(square)
    occupant_icon = square.occupant.icon
    occupant_color = square.occupant.color
    ansi = "\e[48;2;#{square_rgb_val}m\e[38;2;#{icon_rgb_val(occupant_color)}m#{occupied_square(occupant_icon)}\e[0m"
    print ansi
  end

  def square_rgb_val
    Constants::SQUARE_COLOR_RGB_MAP[@active_square_color].gsub(', ', ';')
  end

  def icon_rgb_val(occupant_color)
    Constants::PIECE_COLOR_RGB_MAP[occupant_color].gsub(', ', ';')
  end

  def empty_square
    '   '
  end

  def occupied_square(occupant_icon)
    " #{occupant_icon} "
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
end
