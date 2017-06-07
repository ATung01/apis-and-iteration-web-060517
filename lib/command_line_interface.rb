def welcome
  # puts out a welcome message here!
  puts "Welcome to the Star Wars API Project"
  puts "test"
end

def get_character_from_user
  puts "please enter a character"
  result = gets.chomp
  # use gets to capture the user's input. This method should return that input, downcased.
  user_input = gets.chomp
  user_input.downcase

end
