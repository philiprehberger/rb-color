# frozen_string_literal: true

require_relative 'color/version'
require_relative 'color/ansi'
require_relative 'color/styler'
require_relative 'color/detection'

module Philiprehberger
  module Color
    ANSI_PATTERN = /\e\[[0-9;]*m/

    def self.strip(string)
      string.to_s.gsub(ANSI_PATTERN, '')
    end

    def self.visible_length(string)
      strip(string).length
    end

    def self.enabled?
      Detection.enabled?
    end

    def self.bold
      Styler.new.bold
    end

    def self.dim
      Styler.new.dim
    end

    def self.italic
      Styler.new.italic
    end

    def self.underline
      Styler.new.underline
    end

    def self.invert
      Styler.new.invert
    end

    def self.rgb(red, green, blue)
      Styler.new.rgb(red, green, blue)
    end

    def self.hex(hex_string)
      hex = hex_string.delete('#')
      r = hex[0..1].to_i(16)
      g = hex[2..3].to_i(16)
      b = hex[4..5].to_i(16)
      rgb(r, g, b)
    end

    def self.bg(color_name)
      Styler.new.bg(color_name)
    end

    def self.bg_rgb(red, green, blue)
      Styler.new.bg_rgb(red, green, blue)
    end

    def self.bg_hex(hex_string)
      hex = hex_string.delete('#')
      r = hex[0..1].to_i(16)
      g = hex[2..3].to_i(16)
      b = hex[4..5].to_i(16)
      bg_rgb(r, g, b)
    end

    def self.rainbow(text)
      return text unless enabled?

      colors = [31, 33, 32, 36, 34, 35] # red, yellow, green, cyan, blue, magenta
      text.chars.map.with_index { |c, i| c == ' ' ? c : "\e[#{colors[i % colors.length]}m#{c}\e[0m" }.join
    end

    Ansi::COLORS.each_key do |name|
      define_singleton_method(name) do |string|
        Ansi.wrap(string, Ansi::COLORS[name])
      end
    end
  end
end
