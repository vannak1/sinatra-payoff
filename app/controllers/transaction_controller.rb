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
      account = Account.find_by_id(params[account][id])
      @transaction = Transaction.create(:payment => params[:payment], :account_id => params[account][id])
      account.transaction = @transaction
      redirect to "/account/#{user.accounts.id}"
    end
  end
end
