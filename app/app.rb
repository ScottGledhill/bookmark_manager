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

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links'
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
