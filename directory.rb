# let's put all students into an array

students = [
  {name: "Dr. Hannibal Lecter", cohort: :november},
  {name: "Darth Vader", cohort: :november},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alec DeLarge", cohort: :november},
  {name: "The Wicked Witch of the West", cohort: :november},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :november},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november}, 
  {name: "Norman Bates", cohort:  :november}
]

def print_header
  puts "The students of Villains Acadmey"
  puts "______________"
end

def print(names)
 names.each { |name| puts "#{name[:name]} (#{name[:cohort]} cohort)" }
end

def print_footer(names)
	puts "Overall, we have #{names.count} great students"
end

# Method calls
print_header
print(students)
print_footer(students)

