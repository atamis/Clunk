$:.unshift('../lib/')

require 'clunk'

class ClunkExample < Clunk::CommandList
	def awesome
		puts "Awesome"
	end
	
	define_method(:new) {}
end


@cli = Clunk::CLI.new('test: ', ClunkExample.new)
begin
	@cli.go
rescue ArgumentError => e
	puts e
	retry
end