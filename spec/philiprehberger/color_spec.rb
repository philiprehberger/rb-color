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

  it 'version is a valid semver string' do
    expect(Philiprehberger::Color::VERSION).to match(/\A\d+\.\d+\.\d+\z/)
  end

  describe 'named colors' do
    it 'wraps string with red ANSI codes' do
      result = described_class.red('hello')
      expect(result).to eq("\e[31mhello\e[0m")
    end

    it 'wraps string with green ANSI codes' do
      result = described_class.green('hello')
      expect(result).to eq("\e[32mhello\e[0m")
    end

    it 'wraps string with blue ANSI codes' do
      result = described_class.blue('hello')
      expect(result).to eq("\e[34mhello\e[0m")
    end

    it 'wraps string with yellow ANSI codes' do
      result = described_class.yellow('hello')
      expect(result).to eq("\e[33mhello\e[0m")
    end

    it 'wraps string with cyan ANSI codes' do
      result = described_class.cyan('hello')
      expect(result).to eq("\e[36mhello\e[0m")
    end

    it 'wraps string with magenta ANSI codes' do
      result = described_class.magenta('hello')
      expect(result).to eq("\e[35mhello\e[0m")
    end

    it 'wraps string with white ANSI codes' do
      result = described_class.white('hello')
      expect(result).to eq("\e[37mhello\e[0m")
    end

    it 'wraps string with black ANSI codes' do
      result = described_class.black('hello')
      expect(result).to eq("\e[30mhello\e[0m")
    end

    it 'wraps string with bright_red ANSI codes' do
      result = described_class.bright_red('hello')
      expect(result).to eq("\e[91mhello\e[0m")
    end

    it 'wraps string with bright_green ANSI codes' do
      result = described_class.bright_green('hello')
      expect(result).to eq("\e[92mhello\e[0m")
    end
  end

  describe 'styles' do
    it 'applies bold styling' do
      result = described_class.bold.call('hello')
      expect(result).to eq("\e[1mhello\e[0m")
    end

    it 'applies dim styling' do
      result = described_class.dim.call('hello')
      expect(result).to eq("\e[2mhello\e[0m")
    end

    it 'applies italic styling' do
      result = described_class.italic.call('hello')
      expect(result).to eq("\e[3mhello\e[0m")
    end

    it 'applies underline styling' do
      result = described_class.underline.call('hello')
      expect(result).to eq("\e[4mhello\e[0m")
    end
  end

  describe 'chained styles' do
    it 'chains bold and red' do
      result = described_class.bold.red.call('text')
      expect(result).to eq("\e[1m\e[31mtext\e[0m")
    end

    it 'chains underline and blue' do
      result = described_class.underline.blue.call('text')
      expect(result).to eq("\e[4m\e[34mtext\e[0m")
    end

    it 'chains italic and green' do
      result = described_class.italic.green.call('text')
      expect(result).to eq("\e[3m\e[32mtext\e[0m")
    end

    it 'chains dim and yellow' do
      result = described_class.dim.yellow.call('text')
      expect(result).to eq("\e[2m\e[33mtext\e[0m")
    end

    it 'chains bold, underline, and red' do
      result = described_class.bold.underline.red.call('text')
      expect(result).to eq("\e[1m\e[4m\e[31mtext\e[0m")
    end

    it 'chains color with background' do
      result = described_class.bold.bg(:blue).call('text')
      expect(result).to eq("\e[1m\e[44mtext\e[0m")
    end
  end

  describe 'RGB colors' do
    it 'produces standard RGB escape codes' do
      result = described_class.rgb(255, 100, 50).call('color')
      expect(result).to eq("\e[38;2;255;100;50mcolor\e[0m")
    end

    it 'handles RGB boundary value 0' do
      result = described_class.rgb(0, 0, 0).call('dark')
      expect(result).to eq("\e[38;2;0;0;0mdark\e[0m")
    end

    it 'handles RGB boundary value 255' do
      result = described_class.rgb(255, 255, 255).call('light')
      expect(result).to eq("\e[38;2;255;255;255mlight\e[0m")
    end
  end

  describe 'hex colors' do
    it 'produces hex escape codes with hash prefix' do
      result = described_class.hex('#ff6432').call('color')
      expect(result).to eq("\e[38;2;255;100;50mcolor\e[0m")
    end

    it 'produces hex escape codes without hash prefix' do
      result = described_class.hex('ff6432').call('color')
      expect(result).to eq("\e[38;2;255;100;50mcolor\e[0m")
    end

    it 'handles all-zeros hex' do
      result = described_class.hex('#000000').call('dark')
      expect(result).to eq("\e[38;2;0;0;0mdark\e[0m")
    end

    it 'handles all-max hex' do
      result = described_class.hex('#ffffff').call('light')
      expect(result).to eq("\e[38;2;255;255;255mlight\e[0m")
    end
  end

  describe 'background RGB colors' do
    it 'produces background RGB escape codes' do
      result = described_class.bg_rgb(255, 100, 50).call('color')
      expect(result).to eq("\e[48;2;255;100;50mcolor\e[0m")
    end

    it 'chains foreground and background RGB' do
      result = described_class.rgb(255, 255, 255).bg_rgb(0, 0, 128).call('text')
      expect(result).to eq("\e[38;2;255;255;255m\e[48;2;0;0;128mtext\e[0m")
    end
  end

  describe 'background hex colors' do
    it 'produces background hex escape codes' do
      result = described_class.bg_hex('#ff6432').call('color')
      expect(result).to eq("\e[48;2;255;100;50mcolor\e[0m")
    end

    it 'accepts hex without hash prefix' do
      result = described_class.bg_hex('0000ff').call('text')
      expect(result).to eq("\e[48;2;0;0;255mtext\e[0m")
    end
  end

  describe 'background colors' do
    it 'applies background color' do
      result = described_class.bg(:red).call('hello')
      expect(result).to eq("\e[41mhello\e[0m")
    end

    it 'applies green background' do
      result = described_class.bg(:green).call('hello')
      expect(result).to eq("\e[42mhello\e[0m")
    end

    it 'applies blue background' do
      result = described_class.bg(:blue).call('hello')
      expect(result).to eq("\e[44mhello\e[0m")
    end

    it 'ignores unknown background color' do
      result = described_class.bg(:nonexistent).call('hello')
      expect(result).to eq("hello\e[0m")
    end
  end

  describe 'empty string input' do
    it 'wraps empty string with color codes' do
      result = described_class.red('')
      expect(result).to eq("\e[31m\e[0m")
    end

    it 'wraps empty string with chained styles' do
      result = described_class.bold.red.call('')
      expect(result).to eq("\e[1m\e[31m\e[0m")
    end
  end

  context 'when NO_COLOR is set' do
    around do |example|
      ENV.delete('FORCE_COLOR')
      ENV['NO_COLOR'] = '1'
      example.run
    end

    it 'returns plain string for named colors' do
      result = described_class.red('hello')
      expect(result).to eq('hello')
    end

    it 'returns plain string for styled output' do
      result = described_class.bold.call('hello')
      expect(result).to eq('hello')
    end

    it 'returns false for enabled?' do
      expect(described_class.enabled?).to be false
    end
  end

  context 'when FORCE_COLOR is set' do
    it 'returns true for enabled?' do
      expect(described_class.enabled?).to be true
    end
  end

  describe '.strip' do
    it 'removes ANSI color codes' do
      colored = described_class.red('hello')
      expect(described_class.strip(colored)).to eq('hello')
    end

    it 'removes multiple style codes' do
      styled = described_class.bold.underline.call('test')
      expect(described_class.strip(styled)).to eq('test')
    end

    it 'returns plain string unchanged' do
      expect(described_class.strip('plain')).to eq('plain')
    end

    it 'handles empty string' do
      expect(described_class.strip('')).to eq('')
    end

    it 'handles nil' do
      expect(described_class.strip(nil)).to eq('')
    end
  end

  describe '.visible_length' do
    it 'returns length without ANSI codes' do
      colored = described_class.red('hello')
      expect(described_class.visible_length(colored)).to eq(5)
    end

    it 'returns correct length for plain string' do
      expect(described_class.visible_length('hello')).to eq(5)
    end

    it 'handles chained styles' do
      styled = described_class.bold.red.call('test')
      expect(described_class.visible_length(styled)).to eq(4)
    end
  end

  describe '.rainbow' do
    it 'applies cycling colors to each character' do
      result = described_class.rainbow('abcdef')
      expect(result).to eq(
        "\e[31ma\e[0m\e[33mb\e[0m\e[32mc\e[0m\e[36md\e[0m\e[34me\e[0m\e[35mf\e[0m"
      )
    end

    it 'cycles colors beyond six characters' do
      result = described_class.rainbow('abcdefg')
      # 7th char wraps back to red (31)
      expect(result).to end_with("\e[31mg\e[0m")
    end

    it 'preserves spaces without coloring them' do
      result = described_class.rainbow('a b')
      expect(result).to eq("\e[31ma\e[0m \e[32mb\e[0m")
    end

    it 'returns plain text when color is disabled' do
      ENV.delete('FORCE_COLOR')
      ENV['NO_COLOR'] = '1'
      result = described_class.rainbow('hello')
      expect(result).to eq('hello')
    end

    it 'handles empty string' do
      result = described_class.rainbow('')
      expect(result).to eq('')
    end
  end

  describe 'Styler immutability' do
    it 'does not mutate the original Styler when chaining' do
      base = described_class.bold
      base.red.call('a')
      result = base.blue.call('b')
      expect(result).to eq("\e[1m\e[34mb\e[0m")
    end
  end

  describe '.enabled? detection' do
    it 'respects FORCE_COLOR over NO_COLOR' do
      ENV['FORCE_COLOR'] = '1'
      ENV['NO_COLOR'] = '1'
      expect(described_class.enabled?).to be true
    end
  end
end
