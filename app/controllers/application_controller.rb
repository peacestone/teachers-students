require_relative '../../config/environment.rb'
require "pry"
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "dragon ball"
  end


  get "/" do
    if logged_in?
      redirect "/subjects"
    else
      erb :index
    end    
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    def current_teacher
      @teacher ||= Teacher.find_by(id: session[:id])
    end

    def logged_in?
      !!current_teacher
    end
  end


end
