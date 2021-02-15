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

# exercise 7 - set cohort entry to convert to a symbol and allows you to set a default cohort for all your entries.
# exercise 10 - used rstrip instead of .chomps to remove \n from the gets input

def input_students
  puts "Set cohort default for all? type Cohort name or press enter to not set default."
  cohort_default = gets.chomp.to_sym
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
      if category == cohort
	if !cohort_default.empty?
	  puts "Cohort pre-set to #{cohort_default}"
	  student[category] = cohort_default
	else
	  input = gets.chomp.to_sym
	  while input.empty?
	    puts "Please enter input" 
	    input = gets.chomp.to_sym
          end
	  student[category] = input
      	end
      else
	 input = gets.rstrip
         while input.empty?
	   puts "Please enter input" 
	   input = gets.rstrip
         end
         student[category] = input
      end
    end 
    puts student
    students << student
    puts "Now we have #{students.count} #{students.count == 1 ? "student" : "students"}"
    puts "Enter another student? Type yes or no."
    decision = gets.chomp.downcase
    while decision != 'yes' && decision != 'no'
	puts 'Type yes or no'
	decision = gets.chomp.downcase
    end
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
# exercise 6 - added in center to print option 1 to align all fields into the center
# exercise 8 - added in option to print by cohort, can print out each cohort in one go, or specific cohort.
# exercise 9 - fixed printing statments for singular/plural of student/students

  puts "Do you want: 
The full list of names (enter 1) 
Names beginning with a specific letter (enter 2)
Names with less than 12 characters (enter 3)
Print by cohort (enter 4)"
choice_possibilities = [1, 2, 3, 4]
  choice = gets.chomp.to_i
  while !choice_possibilities.include?(choice) 
    puts "Please select #{choice_possibilities}."
    choice = gets.chomp.to_i
  end

  print_header

  if choice == 1
    counter = 0
    while counter < names.length
        print_array = ""
	names[counter].map{ |y, z| print_array << "#{y}: #{z}, "} 
	puts "#{counter + 1}. #{print_array.to_s}".center(100) 
	counter += 1
    end

  elsif choice == 2
    puts "what letter would you like?"
    letter = gets.chomp.downcase
    while letter.length != 1
      puts "Please enter a single letter"
      letter = gets.chomp.downcase
    end
    counter = 0
    names.each_with_index do |name, index|
      if name[:name][0].downcase == letter
	puts "#{index + 1}. #{name[:name]} (#{name[:cohort]} cohort)"
        counter += 1
      end
    end
    puts "We have #{counter} #{counter == 1 ? "student" : "students"} with a name starting with #{letter.upcase}."

  elsif choice == 3
    counter = 0
    names.each_with_index do |name, index|
      if name[:name].length < 12
        puts "#{index + 1}. #{name[:name]} (#{name[:cohort]} cohort)"
        counter += 1
      end
    end
    puts "We have #{counter} #{counter == 1 ? "student" : "students"}} with a name of less than 12 character."
  
  elsif choice == 4
    puts "Do you want to print all cohorts or a specific cohort? Type all or specific"
    choice_poss = ['all', 'specific']
    choice = gets.chomp.downcase
    while !choice_poss.include?(choice)
	puts "please enter all or specific"
        choice = gets.chomp.downcase
    end
    cohorts = []
    names.each do |name|
      cohorts << name[:cohort]
    end
    cohorts.uniq!
    if choice == 'all'
      cohorts.each do |cohort|
       puts "Cohort: #{cohort}"
       names.each_with_index { |name, index| puts "#{index + 1}. Name: #{name[:name]}, Age: #{name[:age]}, Hobby: #{name[:hobby]}" if name[:cohort] == cohort}
      end  
    elsif choice == 'specific'
      puts "Please choose a cohort"
      cohorts.each {|x| puts x }
      choice = gets.chomp.to_sym
      while !cohorts.include?(choice)
	puts "Please type an available cohort"
	cohorts.each {|x| puts x}
	choice = gets.chomp.to_sym
      end
      puts "Cohort: #{choice}"
      names.each_with_index { |name, index| puts "#{index + 1}. Name: #{name[:name]}, Age: #{name[:age]}, Hobby: #{name[:hobby]}" if name[:cohort] == choice}
    end
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great #{names.count == 1 ? "student" : "students"}"
end

# Method calls

puts "Select cohort - 1(november cohort) or 2(input own names)"
choice = gets.chomp.to_i
while choice != 1 && choice != 2
 puts "Please type 1 or 2."
 choice = gets.chomp.to_i
end

if choice == 1
  students = students_november_cohort
elsif choice == 2
  students = input_students
end

print(students)
print_footer(students)

