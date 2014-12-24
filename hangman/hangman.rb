require 'yaml'

#the idea is to have a Game object which can be serialized into YAML and then reloaded from YAML back to a game object


class Game
  @@games = Array.new
  def initialize
	@wrong_guesses = 0
	@secret_word = get_word
	@current = "_"*(@secret_word.size - 1)
	@saved = nil
  end
  
  def get_word
    f = IO.readlines("5desk.txt")
	choices = Array.new
	f.each do |word|
	  if (word.size > 5) & (word.size < 12)
        choices.push(word)
      end
    end
	choices.sample
  end
  
  def games
    @@games
  end
  
  def wrong_guesses
    @wrong_guesses
  end
  
  def secret_word
    @secret_word
  end
  
  def current
    @current
  end
  
  def saved
    @saved
  end
  
  def load_game(obj)
    temp = YAML.load(obj::saved)
	@wrong_guesses = temp::wrong_guesses
	@secret_word = temp::secret_word
	@current = temp::current
	@saved = temp::saved
  end
  
  
  def save_game
    @saved = YAML.dump(self)
	@@games.push(@saved)
  end
  
  def get_guess
    puts "your turn to guess"
	guess = gets.chomp
	current_changed = false
	(0..@current.size).each do |i|
	  if guess == @secret_word[i]
	    @current[i] = guess
		current_changed = true
	  end
	end
	if !current_changed & !(guess=="?") & !(guess == "end")
	  @wrong_guesses += 1
	end
	guess
  end
  
  def won?
    won = true
	(0..current.size).each do |i|
	  if current[i] == '_'
	    won = false
	  end
	end
	won
  end
  
  def display_win
    puts "You won!"
  end
  
  def play_game
    
    while !won?
	  g1 = get_guess
	  if g1 == "?"
	    @saved = save_game
	  elsif g1 == "end"
	    break
	  end
	  puts current
	  puts wrong_guesses
	  
	end
	if won?
	  puts "You won!"
	else
	  puts "Game saved."
	end
  end
  
  
end

puts "press L to load a game or anything else to continue"

g1 = Game.new

g1.play_game

puts g1::games

g2 = Game.new

g2.play_game

puts g2::games





