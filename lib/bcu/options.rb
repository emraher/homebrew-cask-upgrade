require "optparse"
require "ostruct"

module Bcu
  class << self; attr_accessor :options; end

  def self.parse!(args)
    options = OpenStruct.new
    options.all = false
    options.force = false
    options.cask = nil
    options.cleanup = false
    options.dry_run = true
    options.no_brew_update = false
    options.quiet = false
    options.list = false

    parser = OptionParser.new do |opts|
      opts.banner = "Usage: brew cu [CASK] [options]"

      opts.on("-a", "--all", "Include apps that auto-update in the upgrade") do
        options.all = true
      end

      opts.on("--cleanup", "Cleans up cached downloads and tracker symlinks after updating") do
        options.cleanup = true
      end

      opts.on("-f", "--force", "Include apps that are marked as latest (i.e. force-reinstall them)") do
        options.force = true
      end

      opts.on("--no-brew-update", "Prevent auto-update of Homebrew, taps, and fomulae before checking outdated apps") do
        options.no_brew_update = true
      end

      opts.on("-y", "--yes", "Update all outdated apps; answer yes to updating packages") do
        options.dry_run = false
      end

      opts.on("-q", "--quiet", "Do not show information about installed apps or current options") do
        options.quiet = true
      end

      opts.on("--list", "Show only a list of upgradable casks.") do
        options.list = true
        options.quiet = true
      end
    end

    parser.parse!(args)

    options.cask = args[0]

    self.options = options
  end
end
