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
    @subject = current_teacher.subjects.new(name: params[:name])

    if params[:student_ids]
      params[:student_ids].each do |id|
        @subject.students << Student.find_by(id: id)
      end
    end
    # if new student inputed
    if !params[:student][:name].empty? || !params[:student][:dob].empty?
      @student = Student.new(params[:student])

      if @student.valid? && @subject.valid?
        @student.save
        @subject.save
        @subject.students << @student
        @subject.save
        redirect "/subjects/#{@subject.id}"
      else
        redirect "/subjects/new"
      end
    end

    # When no new student inputed
    if @subject.valid?
      @subject.save
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
    @subject.name = params[:name]

    #When new student inputed
    if !params[:student][:name].empty? || !params[:student][:dob].empty?
      @student = Student.new(params[:student])
      if @student.valid? && @subject.valid?
        @subject.students.clear
        if params[:student_ids]
          params[:student_ids].each do |id|
            @subject.students << Student.find_by(id: id)
          end
        end
        @student.save
        @subject.save
        @subject.students << @student
        @subject.save
        redirect "/subjects/#{@subject.id}"
      else
        redirect "/subjects/#{@subject.id}/edit"
      end
    #When no new student inputed
    else
      if @subject.valid?
        @subject.students.clear
        if params[:student_ids]
          params[:student_ids].each do |id|
            @subject.students << Student.find_by(id: id)
          end
        end
        @subject.save
        redirect "/subjects/#{@subject.id}"
      else
        redirect "/subjects/#{@subject.id}/edit"
      end
    end
  end

end
