class Game
    attr_reader :player, :word, :board, :misses, :state, :number_of_allowed_misses

    def initialize (player,size_of_word,number_of_allowed_misses,number_of_clues)
        @player = player
        @word = get_random_word(size_of_word)
        @board = '_' * @word.size
        @number_of_allowed_misses = number_of_allowed_misses
        @misses = []
        get_random_clue(number_of_clues)
    end

    def get_random_word(size_of_word)
        dictionary = File.new('lib/dictionary.txt').select do |line|
            line.strip.size == size_of_word
        end
        dictionary[rand(dictionary.size)].to_s.strip
    end

    def get_random_clue(number_of_clues)
        number_of_clues.times do 
            guess(@word.split('')[rand(@word.size)])
        end
    end

    def guess(guess)
        unless game_over?
            if @word.include?(guess)
                @word.split('').each_with_index do |letter, index|
                    if letter == guess
                        @board[index] = letter
                        game_over?
                    end
                end
            else
                @misses.push(guess)
                game_over?  
            end
        end
    end

    def game_over?
        if @board == @word
            @state = :won
            save_score
        elsif @misses.size >= @number_of_allowed_misses
            @state = :lost
        end
    end

    def score
        @word.size + (@number_of_allowed_misses - @misses.size)
    end

    def save_score
        @player.score = score
    end
end