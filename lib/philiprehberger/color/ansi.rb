# frozen_string_literal: true

module Philiprehberger
  module Color
    module Ansi
      RESET     = "\e[0m"
      BOLD      = "\e[1m"
      DIM       = "\e[2m"
      ITALIC    = "\e[3m"
      UNDERLINE = "\e[4m"
      INVERT    = "\e[7m"

      COLORS = {
        black: 30, red:     31, green:   32, yellow:  33,
        blue: 34, magenta: 35, cyan:    36, white:   37,
        bright_black: 90, bright_red:     91, bright_green:   92, bright_yellow:  93,
        bright_blue: 94, bright_magenta: 95, bright_cyan:    96, bright_white:   97
      }.freeze

      BG_COLORS = {
        black: 40, red:     41, green:   42, yellow:  43,
        blue: 44, magenta: 45, cyan:    46, white:   47,
        bright_black: 100, bright_red:    101, bright_green:  102, bright_yellow: 103,
        bright_blue: 104, bright_magenta: 105, bright_cyan:   106, bright_white:  107
      }.freeze

      def self.wrap(string, *codes)
        return string unless Philiprehberger::Color.enabled?

        sequence = codes.map { |c| "\e[#{c}m" }.join
        "#{sequence}#{string}#{RESET}"
      end
    end
  end
end
