class Mastermind
    def initialize
        puts "Enter \"creator\" if you want to create code, enter \"guesser\" if you want to guess"
        while true do
            @choice = String(gets.chomp).to_downcase
            if @choice == "creator" || @choice == "guesser"
                break
            else
                puts "Enter valid word"
            end
        end
        @computer = Computer.new
        if @choice == "guesser"
            @code = @computer.GenerateCode
            @number_of_guesses = 12
            play_guesser
        elsif @choice == "creator"
            @player = Player.new
        end
    end

    def intro
        puts "-------------------------- Instructions -----------------------------------"
        puts "Welcome to Mastermind! In this game you have to guess secret code"
        puts "Code consists of 4 numbers that can be from 1 to 6."
        puts "You have 12 guesses to guess it. With each guess you will get feedback:"
        puts "  The amount of correct numbers in their places"
        puts "  The amount of correct numbers, but they aren't in their places"
        puts "Enter your guesses in order without spaces or other chracters(ex. \"1146\")"
        puts "As you can see numbers can be repeated."
        puts "Good luck!"
        puts "---------------------------------------------------------------------------"
    end

    private def play_guesser
        intro
        @win = false
        while @number_of_guesses>0 do
            puts "You have #{@number_of_guesses} guesses left."
            puts "Enter your 4 number code guess(numbers can be 1-6):"
            puts ""
            input = String(gets.chomp)
            @guess = convert_to_array(input)
            if valid_guess?(@guess)
                @guess = convert_to_ints(@guess)
                if @guess == @code
                    @win = true
                    break
                else
                    @number_of_guesses -= 1
                    puts "There are #{how_many_correct(@guess)} correct numbers IN their places!"
                    puts "There are #{how_many_numbers(@guess)} correct numbers NOT in their places"
                    puts ""
                end
            else
                puts "Please enter valid guess!"
                next
            end
        end
        if @win == true
            puts "Congratulations! You WIN!"
        else 
            puts "You lost. The code was #{@code}. Try again!"
        end
    end

    private def play_creator
        
    end
    private def how_many_correct(guess)
        correct = 0
        @code.each_with_index do |num, i|
            if num == guess[i]
                correct += 1
            end
        end
        correct
    end

    private def how_many_numbers(guess)
        numbers = 0
        code_copy = @code.dup
        guess.each_with_index do |num, i|
            if code_copy.include?(num)
                numbers += 1
                code_copy.delete_at(code_copy.index(num))
            end
        end
        numbers -= how_many_correct(guess)
        if (numbers>=0)
            return numbers
        else
            return 0
        end
    end

    private def valid_guess?(guess)
        if guess.length != 4
            return false
        end
        guess.length.times do |i|
            unless guess[i].to_i>=1 && guess[i].to_i<=6
                return false
            end
        end
        return true
    end
end

class Computer
    def GenerateCode
        code = []
        4.times do |i|
            code[i] = 1 + rand(6)
        end
        code
    end
end

class Player
    attr_reader :player_code
    def initialize
        while true do
            puts "Enter your secret code"
            code = String(gets.chomp)
            code = convert_to_array(code)
            if valid_code?(code)
                code = convert_to_ints(code)
                @player_code = code
                break
            else
                puts "Enter valid code please"
                puts ""
            end
        end
    end
    def valid_code?(guess)
        if guess.length != 4
            return false
        end
        guess.length.times do |i|
            unless guess[i].to_i>=1 && guess[i].to_i<=6
                return false
            end
        end
        return true
    end
end


def convert_to_array(inp)
    guess = []
    inp.length.times do |i|
        guess[i] = inp[i]
    end
    guess
end

def convert_to_ints(guess)
    guess.each_with_index do |num, i|
        guess[i] = num.to_i
    end
    guess
end

test = Mastermind.new