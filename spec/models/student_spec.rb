require 'rails_helper'

RSpec.describe Student do
  describe 'Relationships' do
    it {should have_many :student_courses}
    it {should have_many(:courses).through(:student_courses)}
  end

  describe 'Validations' do
    it {should validate_presence_of :name}
  end
end
