class SubjectsController < ApplicationController

  get "/subjects" do
    #binding.pry
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



end
