require 'rails_helper'

RSpec.describe Student do
  describe 'Relationships' do
    it {should have_many :student_courses}
    it {should have_many(:courses).through(:student_courses)}
  end

  describe 'Validations' do
    it {should validate_presence_of :name}
  end

  describe 'Methods' do
    before :each do
      @student = Student.create!(name: 'Jake')
      @mod_1 = Course.create!(name: 'Mod 1')
      @mod_2 = Course.create!(name: 'Mod 2')
      @mod_3 = Course.create!(name: 'Mod 3')
      @student.student_courses.create!(course_id: @mod_1.id, grade: 90.0)
      @student.student_courses.create!(course_id: @mod_2.id, grade: 95.0)
      @student.student_courses.create!(course_id: @mod_3.id, grade: 100.0)
    end

    it '.courses_with_grades' do
      courses = @student.courses_with_grades
      grades = courses.map do |course|
        course.grade
      end

      expect(courses).to eq([@mod_1,@mod_2,@mod_3])
      expect(grades).to eq([90.0,95.0,100.0])
    end
  end
end
