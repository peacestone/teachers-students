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
      current_teacher.subjects << @subject
    else
      redirect "/subjects/new"
    end
    if params[:student_ids]
      params[:student_ids].each do |id|
        @subject.students << Student.find_by(id: id.to_i)
      end
    end
    if !params[:student][:name].empty? && !params[:student][:dob].empty?
      student = Student.create(params[:student])
      @subject.students << student
    elsif !params[:student][:name].empty? || !params[:student][:dob].empty?
      redirect "/subjects/new"
    end
    @subject.save

    redirect "/subjects/#{@subject.id}"
  end

  get "/subjects/new" do
    if logged_in?
      @students = Student.all
      erb :"subjects/new"
    else
      redirect "/"
    end
  end

  get "/subjects/:id/edit" do
    @subject = Subject.find_by(id: params[:id])
    @students = Student.all
    if logged_in? && current_teacher.subjects.include?(@subject)
      erb :"subjects/edit"
    else
      redirect "/subjects"
    end
  end

  get "/subjects/:id" do
    @subject = Subject.find_by(id: params[:id])
    if logged_in? && current_teacher.subjects.include?(@subject)
      erb :"subjects/show"
    else
      redirect "/subjects"
    end
  end




  delete "/subjects/:id/delete" do
    @subject = Subject.find_by(id: params[:id])
    if logged_in? && current_teacher.subjects.include?(@subject)
      @subject.destroy
    end
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

    if !params[:student][:name].empty? && !params[:student][:dob].empty?
      student = Student.create(params[:student])
      @subject.students << student
    elsif !params[:student][:name].empty? || !params[:student][:dob].empty?
      redirect "/subjects/#{@subject.id}/edit"
    end
    @subject.save
    redirect "/subjects/#{@subject.id}"
  end

end
