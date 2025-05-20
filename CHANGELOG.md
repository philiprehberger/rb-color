# Changelog

All notable changes to this gem will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.4.0] - 2026-04-09

### Added
- `bg_rgb(r, g, b)` method for 24-bit background colors
- `bg_hex(hex_string)` method for hex background colors

### Changed
- Fix RGB escape sequence format to use standard `\e[38;2;R;G;Bm` single-sequence encoding
- Make `Styler` immutable — chaining methods return new instances instead of mutating state, making saved references safe to reuse

## [0.3.0] - 2026-04-04

### Added
- `rainbow(text)` method that applies cycling colors (red, yellow, green, cyan, blue, magenta) to each character

## [0.2.0] - 2026-04-04

### Added
- `strip` method for removing ANSI escape sequences from strings
- `visible_length` method for calculating display width without ANSI codes
- GitHub issue template gem version field
- Feature request "Alternatives considered" field

## [0.1.10] - 2026-03-31

### Added
- Add GitHub issue templates, dependabot config, and PR template

## [0.1.9] - 2026-03-31

### Changed
- Standardize README badges, support section, and license format

## [0.1.8] - 2026-03-26

### Changed
- Add Sponsor badge to README
- Fix License section format


## [0.1.7] - 2026-03-24

### Changed
- Add Usage subsections to README for better feature discoverability

## [0.1.6] - 2026-03-24

### Fixed
- Standardize README code examples to use double-quote require statements
- Remove inline comments from Development section to match template

## [0.1.5] - 2026-03-22

### Changed
- Expand test coverage

## [0.1.4] - 2026-03-21

### Fixed
- Standardize Installation section in README

## [0.1.3] - 2026-03-20

### Fixed
- Fix badge order and add Gemfile installation example in README

## [0.1.2] - 2026-03-16

### Changed
- Add License badge to README
- Add bug_tracker_uri to gemspec
- Add Requirements section to README

## [0.1.1] - 2026-03-15

## [0.1.0] - 2026-03-15

### Added
- Initial release
- Named ANSI colors (16 standard colors)
- 256-color palette and RGB/hex support
- Chainable style builder
- Auto-detection of TTY and NO_COLOR env var
