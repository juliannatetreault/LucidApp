require './config/environment'
#require 'rack-flash'

class ApplicationController < Sinatra::Base
#use Rack::Flash, :accessorize => [:notice, :error, :warning]

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "dreamy"
  end

  get "/" do
    erb :welcome
  end

  helpers do 

    def logged_in?
      #!!current_user
      !!session[:id]
    end

    def current_user 
      #@current_user ||= 
      @current_user = User.find_by(id: session[:id])
  end
  
  end
end