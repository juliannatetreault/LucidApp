class UsersController < ApplicationController

  # GET: /users/login
  get "/users/login" do
    if logged_in?
      redirect "/journal_entries"
    else
    erb :"/users/login.html"
    end
  end

  # POST: /users/login
  post "/users/login" do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
        session[:id] = @user.id
        #binding.pry
        redirect "/journal_entries"
    else 
     #flash[:warning] = "Please sign up for an account before logging in."
      redirect "/users/new"
    end
  end

  # GET: /users/new
  get "/users/new" do
    if !logged_in?
      erb :"/users/new.html"
    else  
      redirect "/journal_entries"
    end
  end

  # POST: /users
  post "/users" do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      #flash[:warning] = "Please fill out all fields to create an account."
      redirect "/users/new"
    else 
      @user = User.new(params)
        @user.save
        session[:id] = @user.id
        #flash[:notice] = "You have successfully created an account."
      redirect "/journal_entries"
    end
  end

  get "/users/logout" do
      session[:id] = nil
      #session.clear
      #flash[:notice] = "You have successfully logged out."
      redirect "/"
    #end
  end

  # GET: /users/5
  get "/users/:id" do
    if !logged_in?
      #flash[:error] = "You are not authorized to view this page."
      redirect "/users/login"
    else 
      @user = User.find_by(id: session[:id])
      erb :"/users/show.html"
    end
  end



end
