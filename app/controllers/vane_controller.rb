class VanesController < ApplicationController

  post '/vanes' do
    user = User.find_by_id(session[:user_id])
    user.update(params[:user])
    user.save
    redirect to "/account"
  end
end
