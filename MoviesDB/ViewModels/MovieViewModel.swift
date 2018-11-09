//
//  MovieViewModel.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 08/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import Foundation

class MovieViewModel {
    
    var movies: [Movie] = []
    
    func getMovies(url: String) {
        MoviesService.shared.getMovies(url: url, completion: { response in
            
            do {
                let json = try JSONSerialization.jsonObject(with: response.data!, options: [])
                
                guard let dictionary = json as? [String: Any],
                    let page: Int = dictionary["page"] as? Int,
                    let moviesList = dictionary["results"] as? [[String: Any]] else {
                        print("Error creating dictionary")
                        return
                }
                
                for movie in moviesList {
                    guard let name = (movie["title"] as? String?) ?? "",
                        let overview = (movie["overview"] as? String?) ?? "",
                        let poster = (movie["poster_path"] as? String?) ?? "",
                        let release_date = (movie["release_date"] as? String?) ?? "",
                        let genre_ids = (movie["genre_ids"] as? [Int]?) ?? [] else {
                            print("Erro creating movie")
                            return
                    }
                    
                    let newMovie = Movie()
                    
                    newMovie.name = name
                    newMovie.overview = overview
                    newMovie.poster = poster
                    newMovie.genre_ids = genre_ids
                    newMovie.releaseDate = release_date
                    
                    self.movies.append(newMovie)
                }
            } catch {
                print("erro")
            }
        })
    }
}
