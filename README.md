# philiprehberger-color

[![Tests](https://github.com/philiprehberger/rb-color/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/rb-color/actions/workflows/ci.yml) [![Gem Version](https://badge.fury.io/rb/philiprehberger-color.svg)](https://rubygems.org/gems/philiprehberger-color) [![License](https://img.shields.io/github/license/philiprehberger/rb-color)](LICENSE)

Terminal ANSI color and styling with auto-detection

## Requirements

- Ruby >= 3.1

## Installation

Add to your Gemfile:

```ruby
gem "philiprehberger-color"
```

Or install directly:

```bash
gem install philiprehberger-color
```

## Usage

```ruby
require 'philiprehberger/color'

# Named colors
puts Philiprehberger::Color.red('Error!')
puts Philiprehberger::Color.green('Success!')

# Chainable styling
puts Philiprehberger::Color.bold.red.call('Bold red')
puts Philiprehberger::Color.underline.cyan.call('Underlined cyan')

# Background colors
puts Philiprehberger::Color.bg(:yellow).call('Yellow background')

# RGB and hex colors
puts Philiprehberger::Color.rgb(255, 165, 0).call('Orange')
puts Philiprehberger::Color.hex('#ff6432').call('Custom color')

# Detection
Philiprehberger::Color.enabled? # => true (when TTY)
```

## API

### Named Colors

| Method | Code |
|--------|------|
| `Color.black(str)` | 30 |
| `Color.red(str)` | 31 |
| `Color.green(str)` | 32 |
| `Color.yellow(str)` | 33 |
| `Color.blue(str)` | 34 |
| `Color.magenta(str)` | 35 |
| `Color.cyan(str)` | 36 |
| `Color.white(str)` | 37 |
| `Color.bright_black(str)` | 90 |
| `Color.bright_red(str)` | 91 |
| `Color.bright_green(str)` | 92 |
| `Color.bright_yellow(str)` | 93 |
| `Color.bright_blue(str)` | 94 |
| `Color.bright_magenta(str)` | 95 |
| `Color.bright_cyan(str)` | 96 |
| `Color.bright_white(str)` | 97 |

### Styling

| Method | Description |
|--------|-------------|
| `Color.bold` | Returns chainable Styler with bold |
| `Color.dim` | Returns chainable Styler with dim |
| `Color.italic` | Returns chainable Styler with italic |
| `Color.underline` | Returns chainable Styler with underline |
| `Color.rgb(r, g, b)` | Returns Styler with 24-bit foreground color |
| `Color.hex(hex_string)` | Returns Styler with hex foreground color |
| `Color.bg(color_name)` | Returns Styler with background color |

### Detection

| Method | Description |
|--------|-------------|
| `Color.enabled?` | `true` if stdout is a TTY and `NO_COLOR` is not set |

Set `NO_COLOR` to disable color output. Set `FORCE_COLOR` to force color output regardless of TTY.

## Development

```bash
bundle install
bundle exec rspec      # Run tests
bundle exec rubocop    # Check code style
```

## License

MIT
