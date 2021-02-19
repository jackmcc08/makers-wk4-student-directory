# This file contains the revised student directory code incorporating the refactored directory_alt_exercises.rb where steps 1 through 8 were completed. This file has the following steps included.
# Step 9 - Added an interactive menu
# Step 10 - refactoring done
# Step 11 and 12 - saving and loading data functions implemented
# Step 13 - Done, created an autoloader, which takes its argument from the command line. Also autoloads a default file 
# Step 14 - as per below
# Exercise 1 - Complete - Input students and load students are different functions, does not violate DRY
# Exercise 2 - Complete - program autoloads .default_november.cohort.csv if no file name is provided. default file is stored with program files. Saved files will be saved in a seperate folder.
# Exercise 3 - Complete - Refactored to a good degree, will have a look again and going to try to refactor into classes to make code a bit more readable.
# Exercise 4 - Complete - majority of actions have success messages, also have built program such that invalid input is not accepted, and made it hard to crash the program.
# Exercise 5 - Complete - Filename save and load is flexible, user can choose where you save and choose which file to load
# Exercise 6 - Complete - with the File Loader (not autoloader) it is refactored to auto close the file, done through passing a block to the File.open command.
# Exercise 7 - Complete - Refactored load and save methods to work with CSV class instead of File class - makes for a slightly simpler code
# Exercise 8 - Complete - Created a Quine which relies on being able to open the file and read through it, which I do not believe is a proper quine, have not figured out how to read each line of code in ruby from the top to the bottom and store it in a string while also making all the code executable.
# README - to write

# GLOBAL VARIABLES, CONSTANTS, REQUIREMENTS

  require "csv"

  $first_run = true

  $school_name = "Villain's Academy (est. 1805)"

  $students_november_cohort = [
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
 
 $current_file_loaded = ""

 $students = "" #either autoloads default_november_cohort or another saved file if specified. If no specification in ARGV - default november_cohort is loaded. 

 
 $instructions = "INSTRUCTIONS
To create a student directory select option 1. You can then display or save that directory with options 2 & 3 respectively.
If you save the directory you can load it in the future with option 4.
Note a student directory has been auto-loaded if you wish to use display or save instantly."

  
# METHODS

def interactive_menu
# 1. Print the menu and ask the user what to do
# 2. Read the input and save it into a variable
# 3. Do what the user has asked
# 4. repeat from step 1
  
  puts 
  puts "Welcome to #{$school_name}".center(100)
  puts "-------------------------".center(100)
  puts

  if $first_run == true
    $students = auto_loader(ARGV)
  else
    if $current_file_loaded == "user inputted directory"
      puts "A #{$current_file_loaded} is currently loaded. Please save it to store permanently.".center(100)
    else
      puts "The file #{$current_file_loaded} is currently loaded.".center(100)
    end
  end

  menu = {
    1 => "Input a new student directory",
    2 => "Display the student directory",
    3 => "Save the students list to a csv file",
    4 => "Load an existing directory",
    5 => "Delete an existing directory", 
    8 => "Quine this program (print out it's source code)",
    9 => "Exit the program" 
  }   
  puts
  puts "-------------------------".center(100)
  
  loop do
    puts "Please select your action (type number of choice):".center(100)
    puts
    menu.each { |key, option| puts "#{key}. #{option}".center(100) }
    puts "-------------------------".center(100)  
  
    puts $instructions.center(100)
    
    choice = STDIN.gets.chomp.to_i
    if menu.has_key?(choice)
  	menu_process(choice)
    end
    puts "Please select from the options below:"
  end
end

# takes decision selected from interactive_menu and calls appropriate method
# all other main methods are run from this method, so students variable which is used as input in each choice is set here
# students is sets as the default november cohort generated in first exercise, if you choose to input the students it sets students as whatever you input. 

def menu_process(selection)

  case selection
    when 1
      puts "You selected to input a new student directory."
      $students = input_students
    when 2
      puts "You selected display the currently loaded student directory"
      display_students($students)
    when 3
      puts "You selected to save the current student directory to a csv file. Note a directory is autocreated to save the files in."
      save_students($students)
    when 4
      puts "You selected load an existing directory file"
      $students = load_students
    when 5
      puts "You selected to delete an existing directory file"
      delete_students
    when 8
      puts "You have selected to Quine this program"
      quine
    when 9 
      puts "You selected exit the program, the program will now Exit...Have a Great Day!"
      exit
    else
      puts "Menu choice not valid, please try again" 
  end
  interactive_menu
end

# INPUT STUDENTS CODE
def input_students
  # option to set default cohort for all entered students
  puts
  puts "Would you like to set a default cohort for all entries? Type yes to set default, type no to skip."
  cohort_default_choice = gets.chomp
  while cohort_default_choice != 'yes' && cohort_default_choice != 'no'
    puts "Please type yes to set default or no to skip"
    cohort_default_choice = gets.chomp
  end

  if cohort_default_choice == 'yes'
    puts "Please type in the default cohort name:"
    cohort_default = gets.chomp.to_sym
  end

  # start of entering students (note: future improvement, allow user to set what categories to set)
  puts
  puts "Please enter the names of the students and their details."
  puts "To finish, type no after entering final students hobby and press return."
  students = []
  categories = [:name, :cohort, :age, :hobby]  
  
  # individual student input code
  loop do
    student = {}
    categories.each do |category|
      if cohort_default_choice == 'yes' && category == :cohort
        student[category] = cohort_default
      
      else
        puts "Enter #{category}:"
        input = gets.rstrip
        while input.empty?
          puts "Please enter input:"
          input = gets.chomp
          input = input.to_sym if category == :cohort
        end
   	student[category] = input
      end
    end

    puts "You have entered the following details:\n #{student}"
  
    # Future improvement - opportunity to allow editing here
    
    students << student 
    puts "You have entered #{students.count} #{students.count == 1 ? "student" : "students"} into the directory."
    puts "Enter another student? Type yes or no."
    decision = gets.chomp.downcase
    while decision != 'yes' && decision != 'no'
      puts 'Type yes or no'
      decision = gets.chomp.downcase
    end
    break if decision == 'no'
  end
  
  puts "Would you like to display the list of students entered? Type yes to display or no to return to main menu"
  choice = gets.chomp
  while choice != 'yes' && choice != 'no' do
    puts "Please type yes to display or no to return to the main menu"
    choice = gets.chomp
  end
  display_students(students) if choice == 'yes' 
  
  puts "Remeber to save your student file with option 3 on the main menu to store it for later use. If you do not save it, it will disapear at the end of the session".center(100)
  puts "Press enter to continue".center(100)
  gets.chomp
  
  # array of students returned
  $current_file_loaded = "user inputted directory"
  students
end

# DISPLAY METHODS
# common method for header across each display method
def print_header
  puts
  puts "The students of #{$school_name}".center(100)
  puts "-------------------------------".center(100)
end

# common method for footer across each display method, requires same student input as the display method
def print_footer(students)
  puts "-------------------------------".center(100)
  puts "Overall, we have #{students.count} great #{students.count == 1 ? "student" : "students"}".center(100)
end

# Standard print method for printing a student line - used for consisting formatting across the 4 display options
# requires the method to be called with students.each_with_index to generate the student and counter inputs
def print_student(student, counter)
  print_sentence = "#{counter}. "
  student.each do |category, value|
    if category == :name
      print_sentence << "#{value} - Details:- "
    else
      print_sentence << "#{category}: #{value}, "
    end
  end
  puts print_sentence.center(100)
end

def display_full(students)
  print_header
  students.each_with_index do |student, index|
    print_student(student, index + 1) 
  end
  print_footer(students)
end

def display_by_cohort(students)
  puts "Do you want to print all cohorts or a specific cohort? Type the number for the chosen option:
1. All 
2. Specific"
  all_spec_choice = gets.chomp.to_i
  while all_spec_choice < 1 && all_spec_choice > 2
    puts "Please type all or specific"
    all_spec_choice = gets.chomp.to_1
  end
  
  cohorts = Array.new
  students.each { |student| cohorts << student[:cohort] }
  cohorts.uniq!  # display alphabetically? .sort
  
  if all_spec_choice == 1 #all
    print_header
    cohorts.each do |cohort|
      puts "Cohort: #{cohort}".center(100)
      counter = 0
      students.each_with_index do |student, index|
        if student[:cohort] == cohort
	  print_student(student, index + 1)
          counter += 1
        end
      end
      puts "There #{counter == 1 ? "is" : "are" } #{counter} #{counter == 1 ? "student" : "students"} in the #{cohort} cohort.".center(100)
      puts ""
    end

  elsif all_spec_choice == 2 #'specific'
    puts "Please choose a cohort. Type cohort number"
    cohorts.each_with_index { |cohort, index| puts "#{index + 1}. #{cohort}"}
    cohort_choice = gets.chomp.to_i
    while cohort_choice < 1 || cohort_choice > cohorts.length
      puts "Please choose an available number"
      cohort_choice = gets.chomp.to_i
    end
    
    puts "Cohort: #{cohorts[cohort_choice - 1]}".center(100)
    
    counter = 0
    students.each_with_index do |student, index|
      if student[:cohort] == cohorts[cohort_choice - 1]
        print_student(student, index + 1)
        counter += 1
      end
    end
    puts "There #{counter == 1 ? "is" : "are" } #{counter} #{counter == 1 ? "student" : "students"} in the #{cohorts[cohort_choice - 1]} cohort.".center(100)
  end
  print_footer(students)
end

def display_by_chosen_letter(students)
  puts "What letter do you want to print? Type a single letter, note this is case sensitive"
  letter = gets.chomp
  while letter.length != 1 do
    puts "Please type a single letter"
    letter = gets.chomp
  end
  puts "You are printing all students with a name beginning with #{letter}.".center(100)
  print_header
  counter = 0
  students.each_with_index do |student, index|
    if student[:name][0] == letter
      print_student(student, index + 1)
      counter += 1
    end
  end
  puts "There #{counter == 1 ? "is" : "are" } #{counter} #{counter == 1 ? "student" : "students"} with a name beginning with #{letter}.".center(100)
  print_footer(students)
end

def display_by_chosen_length(students)
  puts "What is the maximum length of name you want to print? Type a whole number (muse be 1 or greater):"
  less_than = gets.chomp.to_i
  while less_than < 1 do
    puts "Please type a number 1 or greater"
    less_than = gets.chomp.to_i
  end
  puts "You are printing all students with a name of less than #{less_than} characters.".center(100)
 
  print_header
  counter = 0
  students.each_with_index do |student, index|
    if student[:name].length < less_than
      print_student(student, index + 1)
      counter += 1
    end
  end
  puts "There #{counter == 1 ? "is" : "are" } #{counter} #{counter == 1 ? "student" : "students"} with a name of less than #{less_than} characters.".center(100)
  print_footer(students)
end


def display_students(students)
  display_options = {
  1 => "Display full list of Students",
  2 => "Display by cohort",
  3 => "Display students beginning with a specific letter",
  4 => "Display students by length of name"
  }
  puts "Choose display option. Type number of option:"
  display_options.each { |key, option| puts "#{key}. #{option}"}
  display_option_choice = gets.chomp.to_i
  while !display_options.has_key?(display_option_choice) do
    puts "That option is not available, please select an available option:"
    display_options.each { |key, option| puts "#{key}. #{option}"}
    display_option_choice = gets.chomp.to_i
  end

  case display_option_choice
   when 1
     puts "you selected #{display_options[display_option_choice]}"
     display_full(students)
   when 2
     puts "you selected #{display_options[display_option_choice]}"
     display_by_cohort(students)
   when 3
     puts "you selected #{display_options[display_option_choice]}"
     display_by_chosen_letter(students)
   when 4
     puts "you selected #{display_options[display_option_choice]}"
     display_by_chosen_length(students)
   else
    puts "That is not an available option"
  end

  puts "\n\n"

  end_method_options = {
  1 => "Return to Display Options",
  2 => "Return to Main Menu",
  3 => "Exit Program"
  }
  puts "What would you like to do? Please type option number:".center(100)
  end_method_options.each { |key, option| puts "#{key}. #{option}".center(100) }
  end_choice = gets.chomp.to_i
  while !end_method_options.has_key?(end_choice) do
    puts "Please select a valid option"
    end_choice = gets.chomp.to_i
  end 

  case end_choice
   when 1
    display_students(students)
   when 2
    interactive_menu
   when 3
    puts "You have selected Exit, goodbye...have a nice day!"
    exit
   else
     puts "You did not select a valid option...".center(100)
  end
  interactive_menu

end

# SAVE METHODS
def save_students(students)
  # create directory to save files
  Dir.mkdir("./saved_directories") if !Dir.exist?("./saved_directories")
  # open the file for writing
 
  puts "What filename would you like to save this file under?
  Note all files are in csv format and saved in a new directory called saved_directories in your current directory"
  file_name = gets.chomp
  puts "are you sure you want to name your file: #{file_name}? Type yes to confirm or no to renter"
  confirm_file_name = gets.chomp
  while confirm_file_name != 'yes' && confirm_file_name != 'no'
    puts "Please enter yes or no"
    confirm_file_name = gets.chomp
  end
  while confirm_file_name == 'no'
    puts "Please re-enter file name:"
    file_name = gets.chomp
    puts "are you sure you want to name your file: #{file_name}? Type yes to confirm or no to renter"
    confirm_file_name = gets.chomp
    while confirm_file_name != 'yes' && confirm_file_name != 'no'
      puts "Please enter yes or no"
      confirm_file_name = gets.chomp
    end
  end
  
  # checks if file already exists, if it does then asks if you want to overwrite or change the name.  
  loop do 
    if File.exist?("./saved_directories/#{file_name}.csv") 
      puts "This file already exists, if you want to proceed this action will overwrite the existing file. Do you want to continue or change the file name? Selection option:
      1. Continue and overwrite file
      2. Change new file name"
      choice = gets.chomp.to_i
      while choice != 1 &&  choice != 2
        puts "Please choose option 1(overwrite) or 2(change name)."
        choice = gets.chomp.to_i
      end
      if choice == 1
        break
      elsif choice == 2
        puts "Please enter the revised file_name, you previously entered #{file_name}."
        file_name = gets.chomp
        puts "are you sure you want to name your file: #{file_name}? Type yes to confirm or no to renter"
        confirm_file_name = gets.chomp
        while confirm_file_name != 'yes' && confirm_file_name != 'no'
          puts "Please enter yes or no"
          confirm_file_name = gets.chomp
        end
        while confirm_file_name == 'no'
          puts "Please re-enter file name:"
          file_name = gets.chomp
          puts "are you sure you want to name your file: #{file_name}? Type yes to confirm or no to renter"
          confirm_file_name = gets.chomp
          while confirm_file_name != 'yes' && confirm_file_name != 'no'
            puts "Please enter yes or no"
            confirm_file_name = gets.chomp
          end
        end
        if !File.exist?("./saved_directories/#{file_name}.csv")
          break
        end
      end
    else
      break
    end
  end
        
  puts "File saving in progress..."

  save_csv(students, file_name)

  puts "File Saved"
  $current_file_loaded = "#{file_name}.csv"
  puts "Press enter to return to main menu."
  gets
  students  
end

def save_csv(students, file_name)

  CSV.open("./saved_directories/#{file_name}.csv", "w+") do |csv|
    category_data = []
    students[0].each_key { |key| category_data << key }
    csv << category_data
    students.each do |student|
      student_data = []
      student.each_value { |value| student_data << value}
      csv << student_data
    end
  end  
end

# LOADING METHODS

def auto_loader(inputs)
  # clears ARGV to reset gets to STDIN sf used
  if !ARGV.empty?
   file_name = ARGV[0] 
   ARGV.clear
  else
   file_name = ".default_november_cohort.csv" 
  end
  $first_run = false
   
  students = []
  if !Dir.exist?("saved_directories")
    puts "There is no directories folder available, please save a file first to enable autoloading from command line".center(100)
    return if file_name != ".default_november_cohort.csv"
  elsif file_name != ".default_november_cohort.csv" && !File.exist?("./saved_directories/#{file_name}") 
    puts "#{file_name} does not exist. A default file will be autoloaded instead.".center(100)
    puts "To load your file in the future please ensure it is saved in the saved_directories folder".center(100)
    file_name = ".default_november_cohort.csv"
  end 
 
  if file_name == ".default_november_cohort.csv"
    if !File.exist?("./#{file_name}") 
      puts "The default autoload file does not exist, please ignore this error message.".center(100)
      return
    else
      students = load_csv("./#{file_name}")
    end
  else
    students = load_csv("./saved_directories/#{file_name}")
  end
 
  if file_name == ".default_november_cohort.csv"
    puts "A default file #{file_name} has been autoloaded.".center(100)
  else
    puts "The file #{file_name} has been autoloaded, you can now display the file or save it under a new name.".center(100)
  end
  $current_file_loaded = file_name
  students 
end

   
def load_students 
  directory_files = {}

  return if check_saved_directories_folder == "no_directory_folder"
  
  if check_for_any_saved_files == "no_files"  
    return #move back to main menu
  else   
    directory_files = list_directories
  end

  puts "What file would you like to load? Please enter the relevant number"
  file_load = gets.chomp.to_i
  while file_load < 1 || file_load > directory_files.length do
    puts "Please choose an available file number"
    file_load = gets.chomp.to_i
  end

  file_name = directory_files[file_load]
  students = load_csv("./saved_directories/#{file_name}")

  puts "You have loaded the file #{file_name} into the students log, you can now display the file or save it under a new name."
  puts "Press enter to return to the main menu"
  gets.chomp
  $current_file_loaded = file_name
  students
end

def check_saved_directories_folder
  if !Dir.exist?("saved_directories")
    puts "You do not have a saved directories folder, please save a directory first.
    press enter to return to main menu"
    gets.chomp
    return "no_directory_folder"
  else
    return true
  end
end

def check_for_any_saved_files
  if Dir.empty?("saved_directories")
    puts "You do not have any saved directories. Please save a directory first."
    puts "Press enter to return to the main menu"
    gets.chomp
    return "no_files"
  else
    return true
  end
end

def list_directories
  directory = []
  directory_files = {}

  puts "You have the following saved directories:"
  directory = Dir.entries("saved_directories")
  counter = 1
  directory.each do |file|
    if file[0] == "." #don't print hidden files in the directory
    else
     directory_files[counter] = "#{file}"
     counter += 1
    end
  end
  directory_files.each { |key, value| puts "#{key}. #{value}"}
  directory_files
end

def load_csv(file_path) #file path must be a string"
  students = []
  csv_array = CSV.read(file_path)
  categories = csv_array[0]
  categories.map! { |category| category.to_sym }
  csv_array[1..-1].each do |line|
    students << categories.zip(line).to_h
  end
  students
end


# DELETE METHODS

def delete_students
  directory_files = {}

  return if check_saved_directories_folder == "no_directory_folder" 
  
  if check_for_any_saved_files == "no_files"
    return #move back to main menu
  else   
    directory_files = list_directories
  end

  puts "What file would you like to delete? Please enter the relevant number, or enter exit to return to main menu"
  file_load = gets.chomp
  while file_load != "exit" && (file_load.to_i < 1 || file_load.to_i > directory_files.length) do 
    puts "Please choose an available file number or 'exit' to return to main menu"
    file_load = gets.chomp
  end

  return if file_load == 'exit'

  file_name = directory_files[file_load.to_i]
 
  puts "Are you sure you want to delete #{file_name}? Type yes to delete, no to return to main menu."
  delete_choice = gets.chomp
  while delete_choice != 'yes' && delete_choice != 'no'
    puts "Please enter 'yes' (delete) or 'no'"
    delete_choice = gets.chomp
  end

  return if delete_choice == 'no' # main menu

  File.delete("./saved_directories/#{file_name}")

  puts "You have now deleted #{file_name}. Press enter to return to main menu."
  gets.chomp

end

#QUINE
def quine
  File.open(__FILE__,"r").readlines.each { |line| print "#{line}" }
  puts
  puts "--END OF QUINE--".center(100)
  puts "Press enter to return to the main menu".center(100)
  gets.chomp
end

# CALL METHODS and SCRIPT

interactive_menu

#menu_choice = interactive_menu
#menu_process(menu_choice)

