#TODO
# leaderboard
# instructions
# trade in a guess for a clue
# nicer formatted missed guesses
# gamification
# better logging / database
# feedback mechanism

require 'sinatra'
require 'rest-client'
require 'flyingv'
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

get '/help' do
	erb :help
end

get '/stats' do
	data = FlyingV.get ('mxit-gallows-number-of-games-played')
	number_of_games_played = data['number_of_games_played']
	data = FlyingV.get ('mxit-gallows-players')
	unique_players = data.values.uniq.first.size
	erb "Games played: #{number_of_games_played}<br /> Unique users: #{unique_players}<br /> Games per player: #{number_of_games_played.to_f/unique_players.to_f}"
end