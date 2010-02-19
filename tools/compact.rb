input = <<END
# This is a comment
puts "this isn't"
puts "Another one"
END
#input = input.split("\n")
input = IO.readlines(ARGV[0])

input2 = []
input.each do |q|
  input2 << q unless q =~ /^[ ]*#/
end

puts input2.join(";")