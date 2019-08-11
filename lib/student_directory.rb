@students = []

# Add student names to the list
# Show list of students
# Edit student details
# Clear student list
# Exit program

def student_list
  file = File.open('student_directory.csv', 'r')
  file.readlines.each do |student|
    puts student
  end
  file.close
  set_menu
end

def edit_student
  existing_students = []

  file = File.open('student_directory.csv', 'r')
  file.readlines.each do |student|
    split_student = student.split(',')
    existing_students << { name: split_student[0], age: split_student[1], gender: split_student[2] }
  end
  file.close

  puts "before"
  puts existing_students
  puts "-------"

  puts "find student name"
  student_name = gets.chomp

  if existing_students.any? { |hash| hash[:name] == student_name }
    puts "ADA BAH"

    student_index = existing_students.index { |hash| hash[:name] == student_name }
    new_data = existing_students[student_index]
    puts "new name"
    new_data[:name] = gets.chomp
    puts "new age"
    new_data[:age] = gets.chomp
    puts "new gender"
    new_data[:gender] = gets.chomp


    puts "after"
    puts existing_students
    puts "-----"

    File.truncate("student_directory.csv", 0)

    existing_students.each do |student|
      File.open("student_directory.csv", "a+") { |file| file.puts "#{student[:name]}, #{student[:age]}, #{student[:gender]}" }
    end
  else
    puts "not exist"
  end
  set_menu
end

def set_menu
  puts "\n\nMAIN MENU\n\n"
  puts "select 1 - add student"
  puts "select 2 - show list of student"
  puts "select 3 - edit student details"
  puts "select 4 - clear student list"
  puts "select 5 - to exit"

  choice = gets.to_i

  if choice == 1
    user_input_msg
  elsif choice == 2
    student_list
  elsif choice == 3
    edit_student
  else
    exit
  end
end

def data_input
  @students.each do |student|
    File.open("student_directory.csv", "a") { |file| file.puts "#{student[:name]}, #{student[:age]}, #{student[:gender]}" }
    File.close
  end
end

def prompt_entry
  puts "do you want to add more student?"
  puts "Y - Yes"
  puts "N - No"

  answer = gets.chomp
  if answer.upcase == "Y"
    user_input_msg
  else
    exit
  end
end

def input_students_msg
  puts "Please enter student name"
  puts "To finish, just hit return"
end

def input_age_msg
  puts "please enter student age"
  puts "To finish, just hit return"
end

def input_gender_msg
  puts "please enter student gender"
  puts "To finish, just hit return"
end

def user_input_msg
  input_students_msg
  name = gets.chomp

  input_age_msg
  age = gets.chomp

  input_gender_msg
  gender = gets.chomp

  @students << {name: name, age: age, gender: gender}
  puts "Now we have #{@students.count} students"
  data_input
  prompt_entry
end

set_menu
# user_input_msg
print(@students)
