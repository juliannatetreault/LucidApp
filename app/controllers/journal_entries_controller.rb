class JournalEntriesController < ApplicationController

  # GET: /journal_entries
  get "/journal_entries" do
    if logged_in?
      @journal_entries = JournalEntry.all
      erb :"/journal_entries/index.html"
    else 
      redirect "/users/login"
  end
end

  # GET: /journal_entries/new
  get "/journal_entries/new" do
    if logged_in?
      erb :"/journal_entries/new.html"
    else  
      redirect "/users/login"
  end
end

  # POST: /journal_entries
  post "/journal_entries" do
    if logged_in?
      @journal_entry = current_user.journal_entries.create(content: params[:content])
      #flash[:notice] = "You have successfully created a new journal entry."
      redirect "/journal_entries"
    else  
      erb :"/journal_entries/new.html"
    end
  end

  # GET: /journal_entries/5/edit
  get "/journal_entries/:id/edit" do
    if logged_in?
      @journal_entry = JournalEntry.find_by_id(params[:id])
      #if current_user.id == @journal_entry.user_id
      if @journal_entry && @journal_entry.user == current_user
      erb :"/journal_entries/edit.html"
      else  
        #flash[:error] = "You are not authorized to edit this entry. Please login to continue."
        redirect "/users/login"
      end
    end
  end
#end
  
  # GET: /journal_entries/5
  get "/journal_entries/:id" do
    if logged_in?
      @journal_entry = JournalEntry.find_by(id: params[:id])
      erb :"/journal_entries/show.html"
    else  
      #flash[:warning] = "You are not authorized to view this page. Please login to continue."
      redirect "/users/login"
  end
end

  # PATCH: /journal_entries/5
  patch "/journal_entries/:id" do
    if logged_in?
      @journal_entry = JournalEntry.find_by(id: params[:id])
      @journal_entry.content = params[:content]
      if @journal_entry.save 
        #flash[:notice] = "You have successfully updated your entry."
    redirect "/journal_entries/#{@journal_entry.id}"
  else 
    redirect to "/journal_entries/#{@journal_entry.id}/edit"
      end
    end
  end

  # DELETE: /journal_entries/5/delete
  delete "/journal_entries/:id/delete" do
    if logged_in?
      @journal_entry = JournalEntry.find_by(id: params[:id])
      if current_user.id == @journal_entry.user_id
          @journal_entry.delete
          #flash[:notice] = "You have successfully deleted your entry."
          redirect "/journal_entries"
      else   
        redirect "/users/new"         
      end
    end
  end
end



