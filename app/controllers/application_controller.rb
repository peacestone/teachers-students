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
    "Awesome!"
  end


end
