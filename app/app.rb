ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative './models/link'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/links' do
    @links = Link.all
    erb :links
  end

  get '/links/new' do
    erb :add_link
  end

  post '/links' do
    link = Link.new(url: params[:url],
                name: params[:name])
    tag  = Tag.create(name: params[:tags])
    link.tags << tag
    link.save
    redirect to('/links')
  end

  run! if app_file == $0
end
