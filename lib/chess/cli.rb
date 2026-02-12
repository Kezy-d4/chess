# frozen_string_literal: true

module Chess
  # Coordinates a game of chess on the command line
  class CLI # rubocop:disable Metrics/ClassLength
    MAIN_MENU_S = <<~HEREDOC
      Chess CLI by Kezy
      1) New Game
      2) Exit
    HEREDOC
    SEPARATOR = '------------------------------------------------------------' \
                "-------------------------------------\n"

    # @param position [Position]
    # @param display [Display]
    def initialize(position, display)
      @position = position
      @display = display
    end

    class << self
      def main_menu_prompt_loop # rubocop:disable Metrics/MethodLength
        loop do
          puts SEPARATOR
          puts MAIN_MENU_S
          input = gets.chomp
          case input
          when '1'
            puts 'Starting...'
            puts SEPARATOR
            return input
          when '2'
            puts 'See you soon'
            puts SEPARATOR
            exit
          else
            puts "Invalid entry: #{input}"
          end
        end
      end

      def player_name_prompt_loop(color) # rubocop:disable Metrics/MethodLength
        loop do
          input = prompt_for_player_name(color)
          if valid_name?(input)
            puts "Welcome, #{input}(#{color})"
            puts SEPARATOR
            return input
          else
            puts "Invalid name: #{input}"
            puts 'Ensure name is between 2 and 15 characters.'
            puts SEPARATOR
          end
        end
      end

      def prompt_for_player_name(color)
        print "Enter a name for the player who will play #{color}: "
        gets.chomp
      end

      def valid_name?(name)
        name.length.between?(2, 15)
      end

      def welcome_players(player_white_name, player_black_name)
        puts "Alright #{player_white_name}(white) and #{player_black_name}(black), " \
             "let's play chess! Enter anything to continue:\n"
        gets.chomp
      end
    end

    def play # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
      loop do
        system('clear')
        puts SEPARATOR
        @display.render_board(@position.to_metadata)
        puts SEPARATOR
        @position.select_source(source_prompt_loop)
        system('clear')
        puts SEPARATOR
        @display.render_board(@position.to_metadata)
        puts SEPARATOR
        destination_input = destination_prompt_loop
        if destination_input == 'esc'
          @position.deselect_source
        else
          @position.move_from_source_to(destination_input)
          @position.deselect_source
          @position.swap_active_player
        end
      end
    end

    def source_prompt_loop
      loop do
        input = prompt_for_source
        if @position.valid_source?(input)
          puts SEPARATOR
          return input
        else
          puts "Invalid entry: #{input}"
          puts SEPARATOR
        end
      end
    end

    def prompt_for_source
      puts <<~HEREDOC
        #{@position.to_active_player}, it's your turn.
        Select one of your squares by its algebraic coordinates:
        #{@position.to_player_associations(@position.to_active_player).keys.map(&:to_s)}
      HEREDOC
      gets.chomp
    end

    def destination_prompt_loop
      loop do
        input = prompt_for_destination.downcase
        return input if @position.valid_move_from_source_to?(input) || input == 'esc'

        puts "Invalid entry: #{input}"
        puts SEPARATOR
      end
    end

    def prompt_for_destination
      puts <<~HEREDOC
        #{@position.to_active_player}, select a destination for your current selection:
        #{@position.source_to_adjacent_controlled_coords.values.flatten}
        Alternatively, type "esc" to go back and select another square.
      HEREDOC
      gets.chomp
    end
  end
end
