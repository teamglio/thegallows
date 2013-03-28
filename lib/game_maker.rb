require 'flyingv'

class GameMaker
    SCORE_RANGE_LEVEL_1 = 0..499 
    SCORE_RANGE_LEVEL_2 = 500..999
    SCORE_RANGE_LEVEL_3 = 1000..1499
    SCORE_RANGE_LEVEL_4 = 1500..1999
    SCORE_RANGE_LEVEL_5 = 2000..9999

    WORD_RANGE_LEVEL_1 = 2..4 
    WORD_RANGE_LEVEL_2 = 5..10
    WORD_RANGE_LEVEL_3 = 11..15
    WORD_RANGE_LEVEL_4 = 16..20
    WORD_RANGE_LEVEL_5 = 21..24

    GUESSES_LEVEL_1 = 9 
    GUESSES_LEVEL_2 = 8 
    GUESSES_LEVEL_3 = 7 
    GUESSES_LEVEL_4 = 6 
    GUESSES_LEVEL_5 = 5

    CLUES_LEVEL_1 = 1 
    CLUES_LEVEL_2 = 1
    CLUES_LEVEL_3 = 2
    CLUES_LEVEL_4 = 2
    CLUES_LEVEL_5 = 2

    def self.get_level(player)
        case player.score
        when SCORE_RANGE_LEVEL_1
            "1"
        when SCORE_RANGE_LEVEL_2
            "2"
        when SCORE_RANGE_LEVEL_3
            "3"
        when SCORE_RANGE_LEVEL_4
            "4"
        when SCORE_RANGE_LEVEL_5
            "5"
        else
            puts "Out of range"                            
        end
    end


    def self.create_game(player)
        track_game
        track_player(player)
        case player.score
        when SCORE_RANGE_LEVEL_1
            Game.new(player,rand(WORD_RANGE_LEVEL_1),GUESSES_LEVEL_1,CLUES_LEVEL_1)
        when SCORE_RANGE_LEVEL_2
            Game.new(player,rand(WORD_RANGE_LEVEL_2),GUESSES_LEVEL_2,CLUES_LEVEL_2)
        when SCORE_RANGE_LEVEL_3
            Game.new(player,rand(WORD_RANGE_LEVEL_3),GUESSES_LEVEL_3,CLUES_LEVEL_3)
        when SCORE_RANGE_LEVEL_4
            Game.new(player,rand(WORD_RANGE_LEVEL_4),GUESSES_LEVEL_4,CLUES_LEVEL_4)
        when SCORE_RANGE_LEVEL_5
            Game.new(player,rand(WORD_RANGE_LEVEL_5),GUESSES_LEVEL_5,CLUES_LEVEL_5)
        else
            puts "Out of range"                            
        end
    end

    def self.track_game
        number_of_games_played = FlyingV.get('mxit-gallows-number-of-games-played')['number_of_games_played']
        number_of_games_played += 1 
        FlyingV.post('mxit-gallows-number-of-games-played', {:number_of_games_played => number_of_games_played})
        #FlyingV.post('mxit-gallows-number-of-games-played', {:number_of_games_played => 0})
    end

    def self.track_player(player)
        players = FlyingV.get('mxit-gallows-players')['players']
        players.push(player.id) 
        FlyingV.post('mxit-gallows-players', {:players => players.uniq})
        #FlyingV.post('mxit-gallows-players', {:players => ''})
    end
end