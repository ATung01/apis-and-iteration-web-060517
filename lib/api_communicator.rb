require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  wanted_person_hash = find_person(character,character_hash)

  while wanted_person_hash == nil
    break if character_hash["next"] == nil
    all_characters = RestClient.get(character_hash["next"])
    character_hash = JSON.parse(all_characters)
    wanted_person_hash = find_person(character,character_hash)
  end
  #hash of "luke"
  # binding.pry
  our_films = find_films(wanted_person_hash)
# binding.pry

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

  # Find the person (Luke Skywalker)
  # Find films
end


def shorten_results(character_hash)
  # removes everything from the character_hash except the "results" key.
  result = character_hash["results"]
  # array of results
end

def find_person(sw_char, character_hash)
  # takes in the original hash, calls shorten_results on it, and returns the requested person as a hash (not an array.)
   result = shorten_results(character_hash).select do |person, trash|
    #  binding.pry
    person["name"].downcase == sw_char
  end[0]

  #  binding.pry
end
 #
 # character_hash = get_character_movies_from_api("Darth Vader")
#
  # puts find_person("Darth Vader", character_hash)

def find_films(single_character_hash)
  # returns an array of film Urls for the given character_hash.
  # binding.pry
  single_character_hash["films"]
end

# find_films("Darth Vader", character_hash)

def parse_character_movies(films_array)
  # some iteration magic and puts out the movies in a nice list
  # {"results" => [].select("films")}
  films_array.map do |film_url|
    JSON.parse(RestClient.get(film_url))["title"]
  end

end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  parse_character_movies(films_array).each do |movie|
    puts movie
  end
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
