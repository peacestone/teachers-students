class StudentsSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :students_subjects do |t|
      t.integer :subject_id
      t.integer :student_id
    end
  end
end
