class ListsController < ApplicationController

    get '/books/:id/lists/new' do
      if is_logged_in?
        @book = Book.find(params[:id])
        erb :'/lists/new'
      else
        erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
      end
    end
  
    post '/books/:id/lists' do
      if params[:title].empty? || params[:content].empty?
        @book = Book.find(session[:user_id])
        erb :'/lists/new', locals: {message: "There seems to be an error. Please try again."}
      else
        @book = Book.find(params[:id])
        @list = List.new(title: params[:title], content: params[:content])
        @list.save
        @book.lists << @list
        redirect "/books/#{@book.id}"
      end
    end
    
    get '/books/:bookid/lists/:listid/edit' do
        if is_logged_in?
          @list = List.find(params[:id])
          @trip = Book.find(@list.trip_id)
          if @trip.user_id == session[:user_id]
            erb :'/lists/edit'
          else
            erb :'/books/show', locals: {message: "Sorry, you do not have permission to edit this list."}
          end
        else
          erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
        end
      end
  
    get '/books/:bookid/lists/:listid' do
      if is_logged_in?
        @list = List.find(params[:id])
        erb :'/lists/show'
      else
        erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
      end
    end
  
  
  
    patch '/books/:bookid/lists/:listid' do
      if params[:title].empty? || params[:content].empty?
        @list = List.find(params[:id])
        erb :'/lists/edit', locals: {message: "There seems to be an error. Please try again."}
      else
        @list = List.find(params[:id])
        @list.update(title: params[:title], content: params[:content])
        redirect "books/#{@list.book_id}/lists/#{@list.id}"
      end
    end
  
    delete '/books/:bookid/lists/:listid/delete' do
      @list = List.find(params[:id])
      @list.delete
      redirect "/books/#{@list.book_id}"
    end
  
  end
  