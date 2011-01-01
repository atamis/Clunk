
# A module to simplyfy the making of command line interfaces.
module Clunk
    VERSION = "0.5"

  # The CLI class. Controls everything in clunk.
  class CLI
    attr_accessor :prompt, :commands, :input, :every_time

    # Make a new CLI object. The params are a prompt, which only needs to be
    # printed to the screen, and a command object. Can be anything, but needs a
    # send method.
    def initialize(prompt, commands)
      @prompt = prompt
      @commands = commands
      @input = Proc.new do
        gets.chomp
      end
      @every_time = Proc.new {}
    end

    # Call this, probably in a begin block, to start up the interface. It will
    # call CLI#input to get input, and will send the command, and the rest of
    # the string, to the @commands object.
    def go
      loop do
        print @prompt
        answer = @input.call.split(" ")
        command = answer.shift
        if command == nil
          command = "nil"
        end
        command = command.to_sym
        @commands.send(command, *answer)
      end
    end
  end

  # A command list class with some standard commands already in it. Also includes
  # a method, self.cli_attr_accessor, which acts like attr_accessor, but instead
  # of returning the variable on klass.variable, it puts it. It is suggested you
  # extend this class to add more commands.
  class CommandList
    def initialize

    end

    # Relode the file. Basically, run it again.
    def reload
      puts "Reloading..."
      system("ruby #{$0}")
    end

    # An attr_accessor child that puts the variable instead of returning it when
    # you call klass.variable.
    def self.cli_attr_accessor(*variables)
      variables.each do |v|
        define_method(v) do
          instance_eval("puts @#{v}")
        end

        define_method("#{v}=".to_sym) do |x|
          instance_eval("#{v} = \"#{x}\"")
        end
      end
    end

    # This is run when the person just hits enter, without typing anything
    def nil
      puts "Sent nothing"
    end

    # This method is envoked when a command is not found.
    def method_missing(symbol, *args)
      puts "Command '#{symbol}' not found."
    end
  end
end
