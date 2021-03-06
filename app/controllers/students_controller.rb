class StudentsController < ApplicationController

  get "/students" do
    if logged_in?
      @students = current_teacher.students.distinct
      erb :"students/students"
    else
      redirect "/"
    end
  end

  get "/students/new" do
    if logged_in?
      erb :"students/new"
    else
      redirect "/"
    end
  end

  post "/students" do
    @student = Student.new(name: params[:student][:name], dob: params[:student][:dob])
    if @student.valid? && params[:subject_ids]
      @student.save
      params[:subject_ids].each do |id|
        @student.subjects << Subject.find_by(id: id)
      end
      redirect "/students"
    else
    redirect "/students/new"
    end

  end

  get "/students/:id" do
    @student = Student.find_by(id: params[:id])
    if logged_in? && current_teacher.students.include?(@student)
      @teachers = @student.teachers.distinct
      @subjects = @student.subjects.where("teacher_id = ?", current_teacher.id)
      erb :"students/show"
    else
      redirect "/students"
    end
  end

  patch "/students/:id" do
    @student = current_teacher.students.find_by(id: params[:id])
    @student.update(params[:student])
    if @student.valid?
      redirect "/students/#{@student.id}"
    else
      redirect "/students/#{@student.id}/edit"
    end
  end

  delete "/students/:id/delete" do
    @student = Student.find_by(id: params[:id])
    if logged_in? && current_teacher.students.include?(@student)
      @student.destroy
    end
    redirect "/students"
  end

  get "/students/:id/edit" do
    @student = Student.find_by(id: params[:id])
    if logged_in? && current_teacher.students.include?(@student)
      erb :"students/edit"
    else
      redirect "/students"
    end
  end

end
