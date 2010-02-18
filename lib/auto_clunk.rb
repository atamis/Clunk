
require 'clunk'
module Clunk
  
  # A simple method of using Clunk. Example:
  #
  # 
  #   require 'auto_clunk'
  #
  #   Clunk::AutoClunk.goes :TestingAutoClunk
  #
  #   class TestingAutoClunk < Clunk::AutoClunk
  #     def juliet
  #       puts "Do not deny to him that you love me."
  #     end
  #   end
  #
  # If you run this, it should allow you to type in "juliet" and get something
  # back. Isn't it awesome?
  class AutoClunk < CommandList
    # Generaly, you don't call this. However, you might override. See
    # create_cli_from_prompt for information.
    def initialize
      @cli = Clunk::CLI.new('>>: ', self)
    end

    # Use this to make an AutoClunk instance with your own prompt. How to use:
    #   require 'auto_clunk'
    #
    #   Clunk::AutoClunk.goes :PromptAutoClunkTest
    #   class PromptAutoClunkTest < Clunk::AutoClunk
    #     def initialize # Override initialize
    #       create_cli_from_prompt('This is my awesome prompt: ')
    #     end
    #   end
    def create_cli_from_prompt(p)
      @cli = Clunk.CLI.new(p, self)
    end

    # Run the CLI. Name choosen for uniqueness. You won't need to use this.
    def activate_awesomeness
      begin
        @cli.go
      rescue ArgumentError => e
        puts e
        retry
      end
    end

    # The method used to alert the module to the name of your class. Uses
    # at_exit to do it's magic.
    def self.goes name
      at_exit {
        eval("#{name.to_s}.new.activate_awesomeness")
      }
    end
  end
end