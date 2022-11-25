require "cohort_repository"

def reset_tables
  seed_sql = File.read("spec/seeds_cohorts_students.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "student_directory_2_test" })
  connection.exec(seed_sql)
end

describe CohortRepository do
  before(:each) do
    reset_tables
  end

  it "finds a cohort with related students" do
    repo = CohortRepository.new
    cohort = repo.find_with_students(1)

    expect(cohort.name).to eq("January")
    expect(cohort.starting_date).to eq("2022-01-01")
    expect(cohort.students.length).to eq(2)
    expect(cohort.students[0].name).to eq("Bruce Wayne")
    expect(cohort.students[1].name).to eq("Clark Kent")
  end
end
