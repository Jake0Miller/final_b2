require 'rails_helper'

RSpec.describe 'Student Show Page' do
  describe 'I visit as a user' do
    before :each do
      @student = Student.create!(name: 'Jake')
      @mod_1 = Course.create!(name: 'Mod 1')
      @mod_2 = Course.create!(name: 'Mod 2')
      @mod_3 = Course.create!(name: 'Mod 3')
      @student.student_courses.create!(course_id: @mod_1.id, grade: 90.0)
      @student.student_courses.create!(course_id: @mod_2.id, grade: 95.0)
      @student.student_courses.create!(course_id: @mod_3.id, grade: 100.0)
      visit student_path(@student)
    end

    it 'I see their name' do
      expect(page).to have_content("Student Name: #{@student.name}")
    end

    it 'I see their courses' do
      expect(page).to have_content("Course List")

      within "#course-#{@mod_1.id}" do
        expect(page).to have_content("Name: #{@mod_1.name}")
        expect(page).to have_content("Grade: #{@mod_1.student_courses.first.grade}")
      end

      within "#course-#{@mod_2.id}" do
        expect(page).to have_content("Name: #{@mod_2.name}")
        expect(page).to have_content("Grade: #{@mod_2.student_courses.first.grade}")
      end

      within "#course-#{@mod_3.id}" do
        expect(page).to have_content("Name: #{@mod_3.name}")
        expect(page).to have_content("Grade: #{@mod_3.student_courses.first.grade}")
      end
    end
  end
end
