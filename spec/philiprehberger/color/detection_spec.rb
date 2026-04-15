# frozen_string_literal: true

require 'philiprehberger/color'

RSpec.describe Philiprehberger::Color::Detection do
  describe '.truecolor?' do
    around do |example|
      old_colorterm = ENV.delete('COLORTERM')
      example.run
    ensure
      ENV.delete('COLORTERM')
      ENV['COLORTERM'] = old_colorterm if old_colorterm
    end

    it 'returns true when COLORTERM is truecolor' do
      ENV['COLORTERM'] = 'truecolor'
      expect(described_class.truecolor?).to be true
    end

    it 'returns true when COLORTERM is 24bit' do
      ENV['COLORTERM'] = '24bit'
      expect(described_class.truecolor?).to be true
    end

    it 'returns true when COLORTERM is TRUECOLOR (case-insensitive)' do
      ENV['COLORTERM'] = 'TRUECOLOR'
      expect(described_class.truecolor?).to be true
    end

    it 'returns false when COLORTERM is ansi' do
      ENV['COLORTERM'] = 'ansi'
      expect(described_class.truecolor?).to be false
    end

    it 'returns false when COLORTERM is unset' do
      ENV.delete('COLORTERM')
      expect(described_class.truecolor?).to be false
    end
  end
end
