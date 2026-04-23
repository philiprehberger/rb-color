# frozen_string_literal: true

module Philiprehberger
  module Color
    class Styler
      def initialize(codes = [])
        @codes = codes
      end

      def call(string)
        Ansi.wrap(string, *@codes)
      end

      def bold
        derive(1)
      end

      def dim
        derive(2)
      end

      def italic
        derive(3)
      end

      def underline
        derive(4)
      end

      def invert
        derive(7)
      end

      def bg(color_name)
        code = Ansi::BG_COLORS[color_name.to_sym]
        code ? derive(code) : derive
      end

      def rgb(red, green, blue)
        derive("38;2;#{red};#{green};#{blue}")
      end

      def bg_rgb(red, green, blue)
        derive("48;2;#{red};#{green};#{blue}")
      end

      Ansi::COLORS.each do |name, code|
        define_method(name) do
          derive(code)
        end
      end

      private

      def derive(*new_codes)
        self.class.new(@codes + new_codes)
      end
    end
  end
end
