class TeachersController < ApplicationController
  get "/teachers/new" do
    erb :"teachers/new"
  end

  post "/teachers" do
    @teacher = Teacher.create(params)
    if @teacher.valid?
      session[:id] = @teacher.id
      redirect "/subjects"
    else
      redirect "/teachers/new"
    end
  end

  post "/teachers/login" do
    @teacher = Teacher.find_by(username: params[:username])
    if @teacher && @teacher.authenticate(params[:password])
      session[:id] = @teacher.id
      redirect "/subjects"
    else
      redirect "/"
    end
  end

end
