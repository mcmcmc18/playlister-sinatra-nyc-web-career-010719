
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  enable :sessions
  use Rack::Flash

  get '/' do
    erb :index
  end

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    erb :'songs/new'
  end

  post '/songs' do
    @song = Song.create(:name => params[:Name])
    @song.artist = Artist.find_or_create_by(:name => params["Artist Name"])
    @song.genre_ids = params[:genres]
    @song.save
    flash[:message] = "Successfully created song."
    redirect to("/songs/#{@song.slug}")
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  get '/artists' do
    @artists = Artist.all
    erb :'artists/index'
  end

  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    erb :'artists/show'
  end

  get '/genres' do
    @genres = Genre.all
    erb :'genres/index'
  end

  get '/genres/:slug' do
    @genre = Genre.find_by_slug(params[:slug])
    erb :'genres/show'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    # @song.artist.find_or_create_by(params["Artist Name"])
    @song.genre_ids = params[:genres]
    @song.artist = Artist.find_or_create_by(:name => params["Artist Name"])

    # @song.genre_ids = params[:genres]
    @song.save
    flash[:message] = "Successfully updated song."
    redirect to("/songs/#{@song.slug}")
  end



    # This should present the user with a list of all songs in the library.
    # Each song should be a clickable link to that particular song's show page.

  # get '/genres' do
  #   erb :show
  #   # This should present the user with a list of all genres in the library.
  #   # Each genre should be a clickable link to that particular genre's show page.
  # end
  #
  # get '/artists' do
  #   erb :show
  #   # This should present the user with a list of all artists in the library.
  #   # Each artist should be a clickable link to that particular artist's show page.
  # end
  #
  # get '/' do
  #   erb :index
  # end





end
