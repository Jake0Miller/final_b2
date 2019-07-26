class StudentsController < ApplicationController
  def show
    @student = Student.find(params[:id])
    @courses = @student.courses_with_grades
  end
end
