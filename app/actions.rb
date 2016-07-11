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
  @track = Track.new(
  song_title: params[:song_title],
  author: params[:author],
  url: params[:url]
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
    redirect 'signup'
  end
end


get '/users' do
  if session[:user_id]
  @users = User.all
  erb:'users/index'
  else
    redirect '/signup'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/signup'
end
