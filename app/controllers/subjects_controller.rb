class SubjectsController < ApplicationController

  get "/subjects" do
    if logged_in?
      @subjects = current_teacher.subjects
      erb :"subjects/subjects"
    else
      redirect "/"
    end
  end

  post "/subjects" do
    if !params[:name].empty?
      @subject = Subject.create(name: params[:name])
    #  binding.pry
      current_teacher.subjects << @subject
      if params[:student_ids]
        params[:student_ids].each do |id|
          @subject.students << Student.find_by(id: id.to_i)
        end
      end
      if !params[:student][:name].empty? && !params[:student][:dob].empty?
        student = Student.create(params[:student])
        @subject.students << student
      end
      @subject.save
    else
      redirect "/subjects/new"
    end

    redirect "/subjects/#{@subject.id}"
  end

  get "/subjects/new" do
    @students = Student.all
    erb :"subjects/new"
  end

  get "/subjects/:id/edit" do
    @subject = Subject.find_by(id: params[:id])
    @students = Student.all
    erb :"subjects/edit"
  end

  get "/subjects/:id" do
    @subject = Subject.find_by(id: params[:id])
    erb :"subjects/show"
  end


  get "/subjects/:id/students/new" do
    @subject = Subject.find_by(id: params[:id])
    erb :"/students/new"

  end

  delete "/subjects/:id/delete" do
    @subject = Subject.find_by(id: params[:id])
    @subject.destroy
    redirect "/subjects"
  end

  post "/subjects/:id" do

    @subject = Subject.find_by(id: params[:id])
    @subject.update(name: params[:name])
    @subject.students.clear
      if params[:student_ids]
        params[:student_ids].each do |id|
          @subject.students << Student.find_by(id: id.to_i)
        end
      end

    if !params[:student][:name].empty?
      student = Student.create(params[:student])
      @subject.students << student
    end
    @subject.save
    redirect "/subjects/#{@subject.id}"
  end



end
