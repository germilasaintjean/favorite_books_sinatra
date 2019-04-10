class BooksController < ApplicationController

    get '/books' do
        if is_logged_in?
          @books = current_user.books
          erb :'/books/index'
        else
          erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
        end
      end
    
      get '/books/all' do
        @books = Book.all
        erb :'/books/all'
      end
    
      get '/books/new' do
        if is_logged_in?
          erb :'/books/new'
        else
          erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
        end
      end
    
      post '/books' do
        if params[:name].empty? || params[:location].empty?
          erb :'/books/new', locals: {message: "There seems to be an error. Please try again."}
        else
          user = current_user
          @book = Book.create(name: params[:name], location: params[:location], user: user_id)
          redirect "/books/#{@book.id}"
        end
      end
    
      get '/books/:id' do
        if is_logged_in?
          @book = Book.find(params[:id])
          erb :'/books/show'
        else
          erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
        end
      end
    
      get '/books/:id/edit' do
        if is_logged_in?
          @book = Book.find(params[:id])
          if @book.user_id == session[:user_id]
            erb :'/books/edit'
          else
            erb :'/books', locals: {message: "Sorry, you do not have permission to edit this book."}
          end
        else
          erb :'/users/login', locals: {message: "Access denied. Please log-in to view."}
        end
      end
    
      patch '/books/:id' do
        if params[:name].empty? || params[:location].empty?
          @book = Book.find(params[:id])
          erb :'/books/edit', locals: {message: "There seems to be an error. Please try again."}
        else
          @book = Book.find(params[:id])
          @book.update(name: params[:name], location: params[:location])
          redirect "/books/#{@book.id}"
        end
      end
    
      delete '/books/:id/delete' do
        @book = Book.find(params[:id])
        @book.delete
        redirect '/books'
      end
    
end