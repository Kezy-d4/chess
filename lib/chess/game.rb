# frozen_string_literal: true

module Chess
  # a game of chess
  class Game
    using StringExtensions

    # @param position [Position]
    # @param display [Display]
    def initialize(position, display)
      @position = position
      @display = display
    end

    def play
      loop do
        turn
      end
    end

    def turn # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      loop do
        render_board_with_separator
        @position.select_source(Coord.from_s(prompt_for_source))
        system('clear')
        render_board_with_separator
        destination = prompt_for_destination
        if valid_escape_input?(destination)
          @position.deselect_source
          system('clear')
          next
        end
        @position.move(@position.dump_log[:metadata][:current_source], Coord.from_s(destination))
        @position.deselect_source
        @position.swap_active_player
        system('clear')
      end
    end

    def prompt_for_source
      sources = @position.to_active_player_sources.map(&:to_s)
      loop do
        puts "#{@position.to_active_player}, it's your turn."
        puts "Select one of your squares:\n#{sources}"
        input = gets.chomp
        return input if valid_source_input?(input)

        print_invalid_submission_msg(input)
      end
    end

    def prompt_for_destination # rubocop:disable Metrics/MethodLength
      return unless @position.source?

      source = @position.dump_log[:metadata][:current_source]
      destinations = @position.to_destinations_from(source).map(&:to_s)
      loop do
        puts "#{@position.to_active_player}, it's your turn."
        puts "Select a destination:\n#{destinations}"
        puts 'Alternatively, submit "esc" to return and select another square.'
        input = gets.chomp
        return input if valid_destination_input?(input) || valid_escape_input?(input)

        print_invalid_submission_msg(input)
      end
    end

    def valid_source_input?(input)
      input.valid_coord? && @position.valid_source?(Coord.from_s(input))
    end

    def valid_destination_input?(input)
      return false unless @position.source?

      source = @position.dump_log[:metadata][:current_source]
      input.valid_coord? && @position.valid_move?(source, Coord.from_s(input))
    end

    def valid_escape_input?(input)
      input.downcase == 'esc'
    end

    private

    def render_board_with_separator
      @display.render_board(@position.to_board_ranks, @position.dump_log[:metadata])
      puts UX::SEPARATOR
    end

    def print_invalid_submission_msg(input)
      puts "Invalid submission: #{input}"
      puts UX::SEPARATOR
    end
  end
end
