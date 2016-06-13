class TransactionsController < ApplicationController

  get '/transaction/new' do
    if session[:user_id]
      user = User.find_by_id(session[:user_id])
      @accounts = user.accounts.all
      erb :'transaction/new'
    else
      redirect to '/login'
    end
  end

  post '/transaction' do
    if params[:payment] == ""
      redirect to "/transaction/new"
    else
      user = User.find_by_id(session[:user_id])
      @transaction = Transaction.create(:payment => params[:payment], :account_id => user.account.id)
      redirect to "/account/#{user.accounts.id}"
    end
  end
end
