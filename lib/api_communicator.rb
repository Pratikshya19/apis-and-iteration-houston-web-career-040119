require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  film_array = []
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(all_characters)
response_hash["results"].each do |character|
  character.each do |key, value|
    if value == character_name
      film_array << character["films"]
    end
  end
end
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
film_array.flatten
end

def get_movies(link)
  response = RestClient.get(link)
  hash = JSON.parse(response)
hash["title"]
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
 films.each do |link|
  puts get_movies(link)

 end
end



def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
