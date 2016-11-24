class StudentsController < ApplicationController

  get "/students" do
    @students = current_teacher.students.distinct
    erb :"students/students"
  end

  post "/students" do
    @student = Student.create(params[:student])
    binding.pry
    redirect "/students"
  end

  get "/students/:id" do
    @student = Student.find_by(id: params[:id])
    @teachers = @student.teachers.distinct if @student
    @subjects = @student.subjects.where("teacher_id = ?", current_teacher.id)
    erb :"students/show"
  end

  patch "/students/:id" do
    @student = Student.find_by(id: params[:id])
    @student.update(params[:student])
    redirect "/students/#{@student.id}"
  end

  delete "/students/:id/delete" do
    @student = Student.find_by(id: params[:id])
    @student.destroy
    redirect "/students"
  end

  get "/students/:id/edit" do
    @student = Student.find_by(id: params[:id])
    erb :"students/edit"
  end

end
