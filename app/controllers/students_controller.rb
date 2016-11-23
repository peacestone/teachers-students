class StudentsController < ApplicationController

  post "/students" do
    #binding.pry
    @subject = Subject.find_by(id: params[:subject_id])
    @student = Student.create(params[:student])
    @subject.students << @student
    redirect "/subjects/#{@subject.id}"
  end

  get "/students/:id" do
    @student = Student.find_by(id: params[:id])
    @teachers = @student.teachers if @student
    @subjects = @student.subjects.where("teacher_id = ?", current_teacher.id)
    erb :"students/show"
  end

end
