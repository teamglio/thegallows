require 'flyingv'

class Player
    attr_reader :id, :name, :score

    def initialize(mxit_user)
        @id = mxit_user.user_id
        @name = mxit_user.nickname

        data = FlyingV.get('mxit-hangman-' + @id)
        @score = data['score'] || 0
    end

    def name=(name)
        @name = name
        save
    end

    def score=(score)
        @score += score
        save
    end

    def reset_score
        @score = 0
        save
    end

    private
    def save
        FlyingV.post('mxit-hangman-' + @id, {:score => @score})
    end
end