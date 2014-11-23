
require 'ostruct'
require 'pastel'

module RubyAppUp
  # Highlight colours for description text, etc.
  class ColourScheme
    def initialize
      pastel = Pastel.new
      @colours = OpenStruct.new alert: pastel.red.bold.detach,
                                command: pastel.green.detach,
                                future: pastel.bright_yellow.bold.detach,
                                mono: pastel.bright_cyan.detach
    end

    def alert(str)
      colours.alert.call str
    end

    def command(str)
      colours.command.call str
    end

    def future(str)
      colours.future.call str
    end

    def mono(str)
      colours.mono.call str
    end

    private

    attr_reader :colours
  end # class RubyAppUp::ColourScheme
end # module RubyAppUp
