require './student'

loop do
  puts "Press enter for a random student or q to quit"
  input = STDIN.gets.strip.downcase
  break if input == "q"

  student = Student.pick(ARGV.first)

  puts student.name
  puts student.two_truths_and_a_lie rescue "No facts on file..."
  puts
end
