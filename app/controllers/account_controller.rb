class AccountsController < ApplicationController
  get '/account' do
    @current_user = User.find_by_id(session[:user_id])
    if @current_user
      erb :"account/accounts"
    else
      redirect to '/login'
    end
  end

  get '/account/new' do
    if session[:user_id]
      erb :'account/new'
    else
      redirect to '/login'
    end
  end

  post '/account' do
    if !params[:account][:date].to_i.between?(0,28)
      erb :"/account/new", locals: {message: "Day must be between 0 and 28."}
    else
      @user = User.find_by_id(session[:user_id])
      params[:account][:user_id] = @user.id
      @accounts = Account.create(params[:account])
      redirect to "/account"
    end
  end

  get '/account/:id' do
    if session[:user_id]
      @accounts = Account.find_by_id(params[:id])
      erb :'account/show'
    else
      redirect to '/login'
    end
  end

  get '/account/:id/edit' do
    if session[:user_id]
      @accounts = Account.find_by_id(params[:id])
      if @accounts.user_id == session[:user_id]
       erb :'account/edit'
      else
        redirect to '/account'
      end
    else
      redirect to '/login'
    end
  end

  patch '/account/:id' do
    if params[:date] != /\d{2}/
      redirect to "/account/#{params[:id]}/edit"
    else
      @accounts = Account.find_by_id(params[:id])
      @accounts.update(params[:account])
      @accounts.save
      redirect to "/account/#{@accounts.id}"
    end
  end

  delete '/account/:id/delete' do
    @accounts = Account.find_by_id(params[:id])
    if session[:user_id]
      @accounts = Account.find_by_id(params[:id])
      if @accounts.user_id == session[:user_id]
        @accounts.delete
        redirect to '/account'
      else
        redirect to '/account'
      end
    else
      redirect to '/login'
    end
  end
end
