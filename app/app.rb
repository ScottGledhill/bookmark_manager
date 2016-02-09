ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require './lib/link'


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
    @name = params['Name']
    @url = params['URL']
    Link.create(name: @name, url: @url)
    redirect '/links'
  end



  run! if app_file == $0
end
