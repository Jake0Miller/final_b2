class Course < ApplicationRecord
  has_many :student_courses
  has_many :students, through: :student_courses

  validates_presence_of :name

  def students_and_grades
    students.joins(:student_courses)
            .select('students.*, student_courses.grade')
            .order('student_courses.grade DESC')
            .order('students.name')
  end
end
