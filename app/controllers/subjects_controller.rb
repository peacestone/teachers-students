class SubjectsController < ApplicationController

  get "/subjects" do
    @subjects = current_teacher.subjects
    erb :"subjects/subjects"
  end

  post "/subjects" do
    @subject = Subject.create(params)
    current_teacher.subjects << @subject
    redirect "/subjects"
  end

  get "/subjects/new" do
    erb :"subjects/new"
  end

  get "/subjects/:id" do
    @subject = Subject.find_by(id: params[:id])
    erb :"subjects/show"
  end

  get "/subjects/:id/students/new" do
    @subject = Subject.find_by(id: params[:id])
    erb :"/students/new"
  end



end
