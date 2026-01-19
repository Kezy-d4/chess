# frozen_string_literal: true

module Chess
  # A mixin which provides miscellaneous helper methods
  module Helper
    def to_class_s
      class_string = self.class.to_s
      class_string.slice!('Chess::')
      class_string
    end
  end
end
