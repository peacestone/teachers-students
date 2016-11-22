class Teacher < ActiveRecord::Base
  has_secure_password
  has_many :subjects
  has_many :students, through: :subjects
end
