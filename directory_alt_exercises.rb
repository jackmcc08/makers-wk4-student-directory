# let's put all students into an array
# commenting out existing students array to replace with user input array

students_november_cohort = [
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

def input_students
  puts "Please enter the names of the students and their details"
  puts "To finish, type no after entering final students hobby and press return."
  # empty array
  students = []
  status = "start"  
  while status == "start"
    student = {}
    categories = [name = :name, cohort = :cohort, age = :age, hobby = :hobby] 
    categories.each do |category|
      puts "Type #{category}"
      student[category] = gets.chomp
    end 
    students << student
    puts "Now we have #{students.count} students"
    puts "Enter another student? Type yes or no."
    decision = gets.chomp.downcase
    status = "stop" if decision == "no"
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Acadmey"
  puts "______________"
end

# exercise 1 - added print index
# exercise 2 - only print those students whose name begin with a specific letter
# exercise 3 - only prints those students whose names begin with less than 12 characters
# exercise 4 - rewrite the each method that prints all students using while or until control flow methods. 
# exercise 5 - added in age and hobby fields, also included print out facility of all information
def print(names)

  puts "Do you want: 
the full list of name (enter 1) 
letters beginning with a specific letter (enter 2)
names with less than 12 characters (enter 3)"

  choice = gets.chomp.to_i

  if choice == 1
    counter = 0
    while counter < names.length
        print_array = ""
	names[counter].map{ |y, z| print_array << "#{y}: #{z}, "} 
	puts "#{counter + 1}. #{print_array.to_s}" 
	counter += 1
    end

  elsif choice == 2
    puts "what letter would you like?"
    letter = gets.chomp.downcase
    counter = 0
    names.each_with_index do |name, index|
      if name[:name][0].downcase == letter
	puts "#{index + 1}. #{name[:name]} (#{name[:cohort]} cohort)"
        counter += 1
      end
    end
    puts "We have #{counter} students with a name starting with #{letter.upcase}."

  elsif choice == 3
    counter = 0
    names.each_with_index do |name, index|
      if name[:name].length < 12
        puts "#{index + 1}. #{name[:name]} (#{name[:cohort]} cohort)"
        counter += 1
      end
    end
    puts "We have #{counter} students with a name of less than 12 character."
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

# Method calls

puts "Select cohort - 1(november cohort) or 2(input own names)"
choice = gets.chomp.to_i

if choice == 1
  students = students_november_cohort
elsif choice == 2
  students = input_students
end

print_header
print(students)
print_footer(students)

