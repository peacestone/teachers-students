class Subject < ActiveRecord::Base
  belongs_to :teacher
  has_and_belongs_to_many :students
  validates :name, presence: true
  validates :teacher, presence: true
  validates :name, uniqueness: { scope: :teacher, case_sensitive: false }
end
