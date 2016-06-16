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
    @account = Account.find(params[:id])
    params[:transac][:account_id] = @account.id
    @transaction = Transaction.create(params[:transac])
    @account.save
    redirect to "/account"
  end
end
