#TODO
# leaderboard
# instructions
# trade in a guess for a clue
# nicer formatted missed guesses
# gamification
# better logging / database

require 'sinatra'
require 'rest-client'
require_relative 'lib/player.rb'
require_relative 'lib/game.rb'
require_relative 'lib/game_maker.rb'
require_relative 'lib/mxit.rb'

enable :sessions

before do
  @mixup_ad = RestClient.get 'http://serve.mixup.hapnic.com/9786245'
end

get '/' do
	@player = Player.new(Mxit.new(request.env))
	session[:player] = @player
	@game = GameMaker.create_game(@player)
	session[:game] = @game

	erb :board
end

post '/play' do
	@player = session[:player]
	@game = session[:game]
	unless @game.state
		@game.guess(params[:play])
		erb :board
	else
	redirect to '/play'		
	end
end

get '/stats' do
	number_of_games_played = RestClient.get 'http://api.openkeyval.org/mxit-gallows-number-of-games-played'
	unique_players = RestClient.get 'http://api.openkeyval.org/mxit-gallows-players'
	erb 'Games played: ' + number_of_games_played + '<br > Unique users: ' + unique_players
end