# frozen_string_literal: true

module Chess
  # A game of chess
  class Game
    SEPARATOR = '------------------------------------------------------------' \
                '-------------------------------------'

    using StringExtensions

    # @param position [Position]
    # @param display [Display]
    def initialize(position, display)
      @position = position
      @display = display
    end

    def play
      take_turns_until_over
      display_game_over_ux
    end

    def take_turns_until_over # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
      loop do
        system('clear')
        render_board_with_separator
        source_inp = prompt_for_source
        @position.select_source(Coord.from_s(source_inp))
        system('clear')
        render_board_with_separator
        post_source_inp = prompt_for_post_source(Coord.from_s(source_inp))
        if legal_escape_input?(post_source_inp)
          @position.deselect_source
          next
        elsif legal_destination_input?(Coord.from_s(source_inp), post_source_inp)
          @position.move(Coord.from_s(source_inp), Coord.from_s(post_source_inp))
          @position.deselect_source
          @position.swap_active_player
          break if over?
        end
      end
    end

    def prompt_for_source
      loop do
        display_source_prompt_ux
        input = gets.chomp
        return input if legal_source_input?(input)

        display_invalid_input_ux(input)
        puts SEPARATOR
      end
    end

    def prompt_for_post_source(source)
      loop do
        display_post_source_prompt_ux(source)
        input = gets.chomp
        return input if legal_escape_input?(input) || legal_destination_input?(source, input)

        display_invalid_input_ux(input)
        puts SEPARATOR
      end
    end

    def legal_source_input?(input)
      input.valid_coord? && @position.legal_source?(Coord.from_s(input))
    end

    def legal_destination_input?(source, input)
      input.valid_coord? && @position.legal_move?(source, Coord.from_s(input))
    end

    def legal_escape_input?(input)
      input.downcase == 'esc'
    end

    def display_source_prompt_ux
      display_prompt_ux
      puts 'Select one of your squares:'
      puts @position.to_player_sources(@position.to_active_player).map(&:to_s).inspect
    end

    def display_post_source_prompt_ux(source)
      display_prompt_ux
      puts 'Select a destination:'
      puts @position.to_legal_destinations_from(source).map(&:to_s).inspect
      puts 'Alternatively, submit "esc" to return and select another square:'
    end

    def display_prompt_ux
      if @position.check?
        puts "#{@position.to_active_player}, you're in check! Your next move must remove check."
      else
        puts "#{@position.to_active_player}, it's your turn."
      end
    end

    def display_game_over_ux
      system('clear')
      render_board_with_separator
      if @position.checkmate?
        puts "#{@position.to_inactive_player} wins by checkmate!"
      elsif @position.stalemate?
        puts 'Draw by stalemate!'
      end
    end

    def display_invalid_input_ux(input)
      puts "Invalid input: #{input}"
    end

    def render_board_with_separator
      @display.render_board(@position.to_board_ranks, @position.dump_log[:metadata])
      puts SEPARATOR
    end
  end
end
