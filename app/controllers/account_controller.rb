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
    if params[:name] == ""
      redirect to "/account/new"
    else
      user = User.find_by_id(session[:user_id])
      @accounts = Account.create(:name => params[:name], :balance => params[:init_balance],
      :interest => params[:interest], :date => params[:due], :min_payment => params[:min_payment], :user_id => user.id)
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
    if params[:name] == ""
      redirect to "/account/#{params[:id]}/edit"
    else
      @accounts = Account.find_by_id(params[:id])
      @accounts.name = params[:name]
      @accounts.balance = params[:init_balance]
      @accounts.min_payment = params[:min_payment]
      @accounts.date = params[:due] #change date to due
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
