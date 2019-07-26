require 'rails_helper'

RSpec.describe 'Course Index Page' do
  describe 'I visit as a user' do
    before :each do
      @mod_1 = Course.create!(name: 'Mod 1')
      @mod_2 = Course.create!(name: 'Mod 2')
      @student_1 = Student.create!(name: 'Jake1')
      @student_2 = Student.create!(name: 'Jake2')
      @student_3 = Student.create!(name: 'Jake3')
      @student_4 = Student.create!(name: 'Aaron')
      @student_5 = Student.create!(name: 'Zach')
      @student_1.student_courses.create!(course_id: @mod_1.id, grade: 90.0)
      @student_2.student_courses.create!(course_id: @mod_1.id, grade: 95.0)
      @student_3.student_courses.create!(course_id: @mod_1.id, grade: 100.0)
      @student_4.student_courses.create!(course_id: @mod_2.id, grade: 100.0)
      @student_5.student_courses.create!(course_id: @mod_2.id, grade: 100.0)
      visit courses_path
    end

    it 'I see each course and the students ordered by grade' do
      expect(page).to have_content("Course List")

      within "#course-#{@mod_1.id}" do
        expect(page.all('#name')[0]).to have_content("Name: #{@student_3.name}")
        expect(page.all('#grade')[0]).to have_content("Grade: #{@student_3.student_courses.first.grade}")
        expect(page.all('#name')[1]).to have_content("Name: #{@student_2.name}")
        expect(page.all('#grade')[1]).to have_content("Grade: #{@student_2.student_courses.first.grade}")
        expect(page.all('#name')[2]).to have_content("Name: #{@student_1.name}")
        expect(page.all('#grade')[2]).to have_content("Grade: #{@student_1.student_courses.first.grade}")
      end

      within "#course-#{@mod_2.id}" do
        expect(page.all('#name')[0]).to have_content("Name: #{@student_4.name}")
        expect(page.all('#grade')[0]).to have_content("Grade: #{@student_4.student_courses.first.grade}")
        expect(page.all('#name')[1]).to have_content("Name: #{@student_5.name}")
        expect(page.all('#grade')[1]).to have_content("Grade: #{@student_5.student_courses.first.grade}")
      end
    end
  end
end
