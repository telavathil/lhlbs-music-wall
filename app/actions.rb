# Homepage (Root path)
get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Track.all
  erb:'tracks/index'
end

get '/tracks/new' do
  # @track = Track.new
  erb:'tracks/new'
end

post '/tracks' do
  #binding.pry
  #create google link from song title
  params[:url] = "https://play.google.com/store/search?q=#{params[:song_title].gsub(/\s/,'+')}&c=music"

  @track = Track.new(
  song_title: params[:song_title],
  author: params[:author],
  url: params[:url],
  user_id: params[:user_id]
  )
  if @track.save
    redirect 'tracks'
  else
    erb:'/tracks/new'
  end
end

get '/tracks/:id' do
  @track = Track.find(params[:id])
  erb:'tracks/show'
end

get '/signup' do
  erb:'signup/index'
end

get '/signin' do
  erb:'signin/index'
end

# get '/signup/oops' do
#
#   erb:'signup/oops'
# end

post '/signup' do
  @user = User.new(
  email: params[:email],
  password: params[:password]
  )
  if @user.save
    session[:user_id] = @user.id
    redirect '/users'
  else
    # binding.pry
    redirect '/signup'
  end
end

post '/signin' do
  #binding.pry
  if user = User.find_by(params[:id])
    session[:user_id] = user.id
    redirect '/'
  else
    @error = "Invalid User"
    erb :'index'
  end
end


get '/users' do
  if session[:user_id]
  @users = User.all
  erb:'users/index'
  else
    redirect '/signin'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

helpers do
  def current_user
    if session[:user_id]
      # @current_user ||= User.find(session[:id])
      return User.find(session[:user_id])
    end
  end

  post '/vote_up_track' do
    Upvote.create(user_id:session[:user_id],track_id: params[:track_id]) unless Upvote.find_by(track_id: params[:track_id], user_id: session[:user_id])
    redirect 'tracks'
  end
end
