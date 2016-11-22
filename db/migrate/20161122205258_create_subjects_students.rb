class CreateSubjectsStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects_students do |t|
      t.integer :subject_id
      t.integer :student_id
    end
  end
end
