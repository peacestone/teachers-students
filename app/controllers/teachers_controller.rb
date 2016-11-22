class TeachersController < ApplicationController
  get "/teachers/new" do
    erb :"teachers/new"
  end

  post "/teachers" do
    @teacher = Teacher.create(params)
    session[:id] = @teacher.id

    erb "subjects/subjects"
  end
end
