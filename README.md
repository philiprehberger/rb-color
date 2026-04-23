# philiprehberger-color

[![Tests](https://github.com/philiprehberger/rb-color/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/rb-color/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/philiprehberger-color.svg)](https://rubygems.org/gems/philiprehberger-color)
[![Last updated](https://img.shields.io/github/last-commit/philiprehberger/rb-color)](https://github.com/philiprehberger/rb-color/commits/main)

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
require "philiprehberger/color"
```

### Named Colors and Styles

Apply standard ANSI colors directly, or chain styles for compound effects:

```ruby
puts Philiprehberger::Color.red("Error!")
puts Philiprehberger::Color.green("Success!")
puts Philiprehberger::Color.bright_cyan("Info")

puts Philiprehberger::Color.bold.red.call("Bold red")
puts Philiprehberger::Color.italic.yellow.call("Italic yellow")
puts Philiprehberger::Color.dim.underline.white.call("Dim underlined")
```

### Invert

Swap foreground and background with reverse video (SGR 7):

```ruby
Philiprehberger::Color.invert.call("selected")
Philiprehberger::Color.bold.invert.call("highlight")
```

### RGB and Hex Colors

Use 24-bit true color with RGB values or hex strings:

```ruby
puts Philiprehberger::Color.rgb(255, 165, 0).call("Orange")
puts Philiprehberger::Color.hex("#ff6432").call("Coral")
puts Philiprehberger::Color.bold.rgb(100, 200, 255).call("Bold sky blue")
```

### Background Colors

Set background colors by name, RGB, or hex, and combine them with foreground styles:

```ruby
puts Philiprehberger::Color.bg(:yellow).call("Yellow background")
puts Philiprehberger::Color.bg(:red).bold.white.call("White on red")
puts Philiprehberger::Color.bg_rgb(0, 0, 128).bright_white.call("White on navy")
puts Philiprehberger::Color.bg_hex("#663399").bold.call("Bold on purple")
```

### Detection

Color output is automatically enabled when stdout is a TTY. Control it with environment variables:

```ruby
Philiprehberger::Color.enabled? # => true (when TTY)

# Disable all color output:  NO_COLOR=1
# Force color output:        FORCE_COLOR=1
```

Check for 24-bit true color support via the `COLORTERM` environment variable:

```ruby
Philiprehberger::Color::Detection.truecolor? # => true when COLORTERM=truecolor or 24bit
```

### Rainbow Text

Apply cycling colors (red, yellow, green, cyan, blue, magenta) to each character:

```ruby
puts Philiprehberger::Color.rainbow("Hello, world!")
```

### Stripping ANSI Codes

```ruby
require "philiprehberger/color"

colored = Philiprehberger::Color.red("hello")
Philiprehberger::Color.strip(colored)           # => "hello"
Philiprehberger::Color.visible_length(colored)   # => 5
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
| `Color.invert` | Returns chainable Styler with reverse video (SGR 7) |
| `Color.rgb(r, g, b)` | Returns Styler with 24-bit foreground color |
| `Color.hex(hex_string)` | Returns Styler with hex foreground color |
| `Color.bg(color_name)` | Returns Styler with background color |
| `Color.bg_rgb(r, g, b)` | Returns Styler with 24-bit background color |
| `Color.bg_hex(hex_string)` | Returns Styler with hex background color |

### Detection

| Method | Description |
|--------|-------------|
| `Color.enabled?` | `true` if stdout is a TTY and `NO_COLOR` is not set |
| `Detection.truecolor?` | `true` if `COLORTERM` is `truecolor` or `24bit` (case-insensitive) |

Set `NO_COLOR` to disable color output. Set `FORCE_COLOR` to force color output regardless of TTY.

### Utilities

| Method | Description |
|--------|-------------|
| `Color.rainbow(str)` | Apply cycling rainbow colors to each character |
| `Color.strip(str)` | Remove all ANSI escape sequences from a string |
| `Color.visible_length(str)` | Return display width of a string excluding ANSI codes |

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## Support

If you find this project useful:

⭐ [Star the repo](https://github.com/philiprehberger/rb-color)

🐛 [Report issues](https://github.com/philiprehberger/rb-color/issues?q=is%3Aissue+is%3Aopen+label%3Abug)

💡 [Suggest features](https://github.com/philiprehberger/rb-color/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement)

❤️ [Sponsor development](https://github.com/sponsors/philiprehberger)

🌐 [All Open Source Projects](https://philiprehberger.com/open-source-packages)

💻 [GitHub Profile](https://github.com/philiprehberger)

🔗 [LinkedIn Profile](https://www.linkedin.com/in/philiprehberger)

## License

[MIT](LICENSE)
