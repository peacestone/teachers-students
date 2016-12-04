class Student < ActiveRecord::Base
  has_and_belongs_to_many :subjects
  has_many :teachers, through: :subjects
  validates :name, presence: true
  validates :dob, presence: true

  validates :name, uniqueness: { scope: :dob, case_sensitive: false }


end
