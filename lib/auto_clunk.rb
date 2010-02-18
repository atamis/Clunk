# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'clunk'
module Clunk
  class AutoClunk < CommandList
    def initialize
      @cli = Clunk::CLI.new('>>: ', self)
    end
    def activate_awesomeness
      begin
        @cli.go
      rescue ArgumentError => e
        puts e
        retry
      end
    end

    def self.goes name
      at_exit {
        eval("#{name.to_s}.new.activate_awesomeness")
      }
    end
  end
end

#Clunk::AutoClunk.new.activate_awesomeness