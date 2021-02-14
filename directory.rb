# let's put all students into an array

students = [
"Dr. Hannibal Lecter",
"Darth Vader",
"Nurse Ratched",
"Michael Corleone",
"Alec DeLarge",
"The Wicked Witch of the West",
"Terminator",
"Freddy Krueger",
"The Joker",
"Joffrey Baratheon", 
"Norman Bates"
]

# and then print them
puts "The students of Villains Acadmey"
puts "______________"

students.each { |x| puts x}

#finally, we print the total number of students
puts "Overall, we have #{students.count} great students"
