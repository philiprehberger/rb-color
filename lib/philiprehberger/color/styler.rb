# frozen_string_literal: true

module Philiprehberger
  module Color
    class Styler
      def initialize
        @codes = []
      end

      def call(string)
        Ansi.wrap(string, *@codes)
      end

      def bold
        @codes << 1
        self
      end

      def dim
        @codes << 2
        self
      end

      def italic
        @codes << 3
        self
      end

      def underline
        @codes << 4
        self
      end

      def bg(color_name)
        code = Ansi::BG_COLORS[color_name.to_sym]
        @codes << code if code
        self
      end

      def rgb(red, green, blue)
        @codes << '38;2'
        @codes << red << green << blue
        self
      end

      Ansi::COLORS.each do |name, code|
        define_method(name) do
          @codes << code
          self
        end
      end
    end
  end
end
