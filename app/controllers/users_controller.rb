class UsersController < ApplicationController

    get '/signup' do 
      if is_logged_in?
        redirect '/books'
      else
       erb :'/users/signup'
      end
    end
  
      get '/users/:id' do
          @user = User.find_by_id(params[:id])
          @books = @user.books
          erb:'/users/show'
      end
  
      post '/signup' do
          @user = User.new(username: params[:username], email: params[:email], password: params[:password])
          if @user.save
            session[:user_id] = @user.id
            redirect '/books'
          else
            erb :'/users/signup', locals: {message: "There seems to be an error. Please try again."}
          end
       end
  
      get '/login' do
         if !is_logged_in?
           erb :'users/login'
          else
          redirect '/books'
          end
       end
  
      post '/login' do
         user = User.find_by(username: params[:username])
         if user && user.authenticate(params[:password])
           session[:user_id] = user.id
           redirect '/books'
          else
            erb :'/users/login', locals: {message: "There seems to be an error. Please try again."}
          end
      end
          
      get '/logout' do
        session.clear
        erb :'/index'
      end
          
    end
          