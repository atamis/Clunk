require 'auto_clunk'

Clunk::AutoClunk.goes :TestingAutoClunk

class TestingAutoClunk < Clunk::AutoClunk
  def awesomeness
    puts "This is a test"
  end
  def juliet
    puts "Do not deny to him that you love me."
  end
  def nil
    puts "I don't like nil"
  end
end