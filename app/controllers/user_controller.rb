class UsersController < ApplicationController

  get '/signup' do
    if !session[:user_id]
      erb :'user/signup', locals: {message: "Please sign up before login."}
    else
      redirect to '/account'
    end
  end

  post '/signup' do
    if params[:user].empty?
      redirect to '/signup'
    else
      @user = User.new(params[:user])
      @user.save
      session[:user_id] = @user.id
      redirect to '/account'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'user/login'
    else
      redirect '/account'
    end
  end

  post '/login' do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/account"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/destroy' do
    User.destroy_all
    Account.destroy_all
    Transaction.destroy_all
    Vane.destroy_all
    session.destroy
    redirect to '/'
  end
end
