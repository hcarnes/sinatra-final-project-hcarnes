class UsersController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if user.save
      sign_in(user)
      redirect "/listings"
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect "/signup"
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      sign_in(user)
      redirect "/listings"
    else
      flash[:message] = "Invalid username or password"
      redirect '/login'
    end
  end

  get '/user/:id' do
    @bids = current_user.bids.all
    erb :'users/show'
  end
end