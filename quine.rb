# Quine Program - a program that prints out its own source code
# (self-replicating program....?)
File.open(__FILE__,"r").readlines.each { |line| print "#{line}"} 
str = <<-str   
puts "str = <<-str"
puts str
puts "str"
puts str
str
puts "str = <<-str"
puts str
puts "str"
puts str

