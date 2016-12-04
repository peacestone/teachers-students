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
    @subject = Subject.create(name: params[:name])

    if params[:student_ids]
      params[:student_ids].each do |id|
        @subject.students << Student.find_by(id: id.to_i)
      end
    end

    if !params[:student][:name].empty? || !params[:student][:dob].empty?
      student = Student.create(params[:student])
      if student.valid?
        @subject.students << student
      else
        redirect "/subjects/new"
      end
    end

    if @subject.valid?
      @subject.save
      current_teacher.subjects << @subject
      redirect "/subjects/#{@subject.id}"
    else
      redirect "/subjects/new"
    end
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
    @subject = current_teacher.subjects.find_by(id: params[:id])
    @subject.update(name: params[:name])

    if @subject.invalid?
      redirect "/subjects/#{@subject.id}/edit"
    end

    @subject.students.clear

    if !params[:student][:name].empty? && !params[:student][:dob].empty?
      student = Student.create(params[:student])
      @subject.students << student
    elsif !params[:student][:name].empty? || !params[:student][:dob].empty?
      redirect "/subjects/#{@subject.id}/edit"
    end

    #@subject.update(name: params[:name])

    #@subject.students.clear
      if params[:student_ids]
        params[:student_ids].each do |id|
          @subject.students << Student.find_by(id: id.to_i)
        end
      end

    @subject.save
    redirect "/subjects/#{@subject.id}"
  end

end
