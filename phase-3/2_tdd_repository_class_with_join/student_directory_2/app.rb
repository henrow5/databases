require_relative "lib/database_connection"
require_relative "lib/cohort_repository"

DatabaseConnection.connect("student_directory_2")

# Print out each record from the result set .
# result.each do |record|
#   p record
# end

repo = CohortRepository.new
cohort1 = repo.find_with_students(1)
cohort2 = repo.find_with_students(2)

puts "#{cohort1.name} Cohort #{cohort1.starting_date}"
cohort1.students.each_with_index do |student, index|
  puts "#{index + 1} - #{student.name}"
end

puts "#{cohort2.name} Cohort #{cohort2.starting_date}"
cohort2.students.each_with_index do |student, index|
  puts "#{index + 1} - #{student.name}"
end
