# frozen_string_literal: true

require 'philiprehberger/color'

RSpec.describe Philiprehberger::Color do
  around do |example|
    old_force = ENV.delete('FORCE_COLOR')
    old_no = ENV.delete('NO_COLOR')
    ENV['FORCE_COLOR'] = '1'
    example.run
  ensure
    ENV.delete('FORCE_COLOR')
    ENV.delete('NO_COLOR')
    ENV['FORCE_COLOR'] = old_force if old_force
    ENV['NO_COLOR'] = old_no if old_no
  end

  it 'has a version number' do
    expect(Philiprehberger::Color::VERSION).not_to be_nil
  end

  it 'wraps string with red ANSI codes' do
    result = described_class.red('hello')
    expect(result).to eq("\e[31mhello\e[0m")
  end

  it 'wraps string with green ANSI codes' do
    result = described_class.green('hello')
    expect(result).to eq("\e[32mhello\e[0m")
  end

  it 'applies bold styling' do
    result = described_class.bold.call('hello')
    expect(result).to eq("\e[1mhello\e[0m")
  end

  it 'chains bold and red' do
    result = described_class.bold.red.call('text')
    expect(result).to eq("\e[1m\e[31mtext\e[0m")
  end

  it 'chains underline and blue' do
    result = described_class.underline.blue.call('text')
    expect(result).to eq("\e[4m\e[34mtext\e[0m")
  end

  context 'when NO_COLOR is set' do
    around do |example|
      ENV.delete('FORCE_COLOR')
      ENV['NO_COLOR'] = '1'
      example.run
    end

    it 'returns plain string' do
      result = described_class.red('hello')
      expect(result).to eq('hello')
    end

    it 'returns false for enabled?' do
      expect(described_class.enabled?).to be false
    end
  end

  it 'produces RGB escape codes' do
    result = described_class.rgb(255, 100, 50).call('color')
    expect(result).to include("\e[38;2m\e[255m\e[100m\e[50m")
    expect(result).to end_with("\e[0m")
  end

  it 'produces hex escape codes' do
    result = described_class.hex('#ff6432').call('color')
    expect(result).to include("\e[38;2m\e[255m\e[100m\e[50m")
  end

  it 'applies background color' do
    result = described_class.bg(:red).call('hello')
    expect(result).to eq("\e[41mhello\e[0m")
  end
end
