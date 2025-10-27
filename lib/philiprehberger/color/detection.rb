# frozen_string_literal: true

module Philiprehberger
  module Color
    module Detection
      def self.enabled?
        return true if ENV.key?('FORCE_COLOR')
        return false if ENV.key?('NO_COLOR')

        $stdout.respond_to?(:tty?) && $stdout.tty?
      end

      def self.truecolor?
        %w[truecolor 24bit].include?(ENV['COLORTERM']&.downcase)
      end
    end
  end
end
