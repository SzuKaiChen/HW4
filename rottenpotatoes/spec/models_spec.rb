require 'rails_helper'

describe Movie, :type => :model do
    it "return the correct matches for the movies by the same director" do
        new_movies = [{"title": "movie_1", "director": "director_a"}, {"title": "movie_3", "director": "director_a"}]
        new_movies.each do |new_movie|
            Movie.create(new_movie)
        end
        
        movies = Movie.same_director("director_a")
        movies = movies.as_json
        expect(movies[0]["director"]).to eq("director_a")
        expect(movies[1]["director"]).to eq("director_a")
    end

    it "should not return matches for the different directors" do
        new_movies = [{"title": "movie_1", "director": "director_a"}, {"title": "movie_2", "director": "director_b"}]
        new_movies.each do |new_movie|
            Movie.create(new_movie)
        end
        
        movies = Movie.same_director("director_b")
        movies = movies.as_json
        expect(movies[0]["director"]).not_to eq("director_a")
    end
end