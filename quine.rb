# Quine Program - a program that prints out its own source code
# (self-replicating program....?)
File.open(__FILE__,"r").readlines.each { |line| print "#{line}"}

#proper quine below
puts "------\n\n"

puts IO.readlines(__FILE__)
puts File.read(__FILE__)

str = <<-str
puts "str = <<-str"
puts str
puts "str"
puts str
str
# puts "str = <<-str"
# puts str
# puts "str"
# puts str

#File.read
#Rspec - point to places or error
