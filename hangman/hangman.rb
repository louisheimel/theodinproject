#need to make program case insensitive
#basic functionality in place, but i need to get serializing and wrong guesses feature to work
f = IO.readlines("5desk.txt")


#randomly select word between 5 and 12 characters long
choices = Array.new
f.each do |word|
  if (word.size > 5) & (word.size < 12)
    choices.push(word)
  end
end

secret_word = choices.sample

current = "_"*(secret_word.length - 1)

puts current
flag = true
wrong_guesses = 0
while flag == true
	puts "guess"

	guess = gets.chomp
	
	right_guess = false
	(0..current.length).each do |i|
	  if secret_word[i] == guess
	    right_guess = true
	  end
	end
	(0..current.length).each do |i|
		  if secret_word[i]==guess
			current[i] = guess
			flag = false
			break
		  
		  end
			
	end
	
	

		(0..current.length).each do |i|
		  if secret_word[i]==guess
			current[i] = guess
		  
		  end
			
		end
	
	
	flag = false
	(0..current.length).each do |i|
	  if current[i] == "_"
	    flag = true
	  end
	end
    puts current
	if !(right_guess)
	  wrong_guesses += 1
	  puts "wrong_guesses:"
	  puts wrong_guesses
	end
	
end

puts "You figured it out!"
