require 'rails_helper'


describe "Routing test", :type => :request do
    it "when the movie has a director" do
        new_movies = [{"title": "movie_1", "director": "director_a"}, {"title": "movie_3", "director": "director_a"}]
        new_movies.each do |new_movie|
            Movie.create(new_movie)
        end
        
        id =  Movie.where(title: "movie_1")[0].as_json["id"]
        get "/movies/#{id}/same_director"
        expect(response).to render_template("same_director")
    end

    it "when the movie has no director" do
        new_movies = [{"title": "movie_2"}]
        new_movies.each do |new_movie|
            Movie.create(new_movie)
        end
        
        id =  Movie.where(title: "movie_2")[0].as_json["id"]
        get "/movies/#{id}/same_director"
        expect(response).to redirect_to("/movies")
    end
    
    it "Running correctly in general" do
        new_movies = [{"title": "movie_1", "director": "director_a", "release_date": "2000-01-01"}]
        new_movies.each do |new_movie|
            Movie.create(new_movie)
        end
        
        get "/movies/1"
        expect(response).to render_template("show")
        
        get "/movies"
        expect(response).to render_template("index")
        
        get "/movies/new"
        expect(response).to render_template("new")
        
        get "/movies/1/edit"
        expect(response).to render_template("edit")
        
        put "/movies/1", "movie": {"title": "movie_2"}
        expect(response).to redirect_to("/movies/1")
        
        delete "/movies/1"
        expect(response).to redirect_to("/movies")
        
    end
end