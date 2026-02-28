# frozen_string_literal: true

require_relative 'lib/chess'

original = Chess::Position.new_default('w', 'b')
clone = original.clone
clone.move(Chess::Coord.from_s('e2'), Chess::Coord.from_s('e4'))

# The original is being modified and shouldn't be. This has been the case for
# each of my attempted implementations.
puts original
