# frozen_string_literal: true

require_relative 'constants'
require_relative 'position'

# Renders board elements to console
class Display
  def initialize(position)
    @position = position
    @active_square_color = :yellow
  end

  # private

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
end

# test script
system('clear')
position = Position.from_fen('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
display = Display.new(position)
display.render_empty_square
display.switch_active_square_color
display.render_occupied_square(position.access_square(:d1))
display.switch_active_square_color
display.render_occupied_square(position.access_square(:e8))
display.switch_active_square_color
display.render_empty_square
puts
gets
