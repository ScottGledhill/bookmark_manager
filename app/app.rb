ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative './models/link'
require_relative 'data_mapper_setup'
require 'dm-validations'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base
  register Sinatra::Flash
  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    erb :index
    redirect('/users/new')
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/links' do
    @links = Link.all
    erb :links
  end

  post '/users/new' do
    User.create(email: params[:email], password: params[:password])
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'

  end

  post '/users' do
    @user = User.new(email: params[:email],
                     password: params[:password],
                     password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect to('/links')
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :links
  end

  get '/links/new' do
    erb :add_link
  end

  post '/links' do
    link = Link.create(url: params[:url], name: params[:name])
    params[:tags].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect to('/links')
  end
run! if app_file == $0
end
