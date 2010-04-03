require 'clunk'

module Clunk
	class SemiAutoClunk < CommandList
		def initialize(prompt)
			@clunk = Clunk::CLI.new(prompt, self)
		end
		
		def go
      begin
        @cli.go
      rescue ArgumentError => e
        puts e
        retry
      end
    end

	end
end