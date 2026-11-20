require "open-uri"
require "json"

puts "Cleaning database..."
Bookmark.destroy_all
Movie.destroy_all

url = "https://tmdb.lewagon.com/movie/top_rated"
response = URI.open(url).read
json = JSON.parse(response)
movies = json["results"]


p "movies ---"
p movies[0]["title"]

movies.each do |movie|
  Movie.create(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}",
    rating: movie["vote_average"]
  )
end

puts "Created #{Movie.count} movies"
