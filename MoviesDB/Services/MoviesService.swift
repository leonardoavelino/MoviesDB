//
//  MoviesService.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 08/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import Foundation
import Alamofire

/// Fetches movies from the movie database.
class MoviesService {

    /// Singleton of the MovieService.
    static let shared = MoviesService()
    
    /// The global genres dictionary.
    var genresList: [String: String] = [:]

    /// Fetches movies from tmdb or search for movies if query parameter is not nil, and returns a movies list.
    ///
    /// - Parameters:
    ///   - page: The page to be requested.
    ///   - query: Query parameter to search for specific movies.
    ///   - completion: Called when the request is done. Contains a movies list,
    ///                 a page number and total pages number on success and a empty movies list otherwise.
    func getMovies(page: Int, query: String?, completion: @escaping (_ movies: [Movie], _ page: Int?, _ pages: Int?) -> Void) {
        
        var queryString = Constants.tmdbMoviesBaseUrl + Constants.tmdbApiKey +
            Constants.pageParameter + page.description + Constants.orderParameter
        
        if let query = query {
            let encodedString = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            queryString = Constants.tmdbSearchMoviesBaseUrl + Constants.tmdbApiKey +
                Constants.pageParameter + page.description + Constants.queryParameter + encodedString!
        }

        Alamofire.request(queryString).responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                var movies: [Movie] = []
                do {
                    let json = try JSONSerialization.jsonObject(with: response.data!, options: [])

                    guard let dictionary = json as? [String: Any],
                        let page: Int = dictionary["page"] as? Int,
                        let pages: Int = dictionary["total_pages"] as? Int,
                        let moviesList = dictionary["results"] as? [[String: Any]] else {
                            print("Error creating dictionary")
                            return
                    }

                    for movie in moviesList {
                        guard let name = (movie["title"] as? String?) ?? "",
                            let overview = (movie["overview"] as? String?) ?? "",
                            let poster = (movie["poster_path"] as? String?) ?? "",
                            let backdrop = (movie["backdrop_path"] as? String?) ?? "",
                            let release_date = (movie["release_date"] as? String?) ?? "",
                            let genre_ids = (movie["genre_ids"] as? [Int]?) ?? [] else {
                                print("Error creating movie")
                                return
                        }

                        let newMovie = Movie()

                        newMovie.name = name
                        newMovie.overview = overview
                        newMovie.poster = poster
                        newMovie.backdrop = backdrop
                        newMovie.genre_ids = genre_ids
                        newMovie.releaseDate = release_date

                        movies.append(newMovie)
                    }
                    completion(movies, page, pages)
                } catch {
                    completion([], nil, nil)
                }
            case .failure:
                print("Error getting movies data")
                completion([], nil, nil)
            }
        })
    }
    
    /// Fetches the global genres list from tmdb.
    ///
    /// - Parameter completion: Called when the genres request is completed.
    func getGenres(completion: @escaping (Bool) -> Void) {
        Alamofire.request(Constants.genresBaseUrl +
            Constants.tmdbApiKey).responseJSON(completionHandler: { [weak self] response in
            switch response.result {
            case .success:
                do {
                    let json = try JSONSerialization.jsonObject(with: response.data!, options: [])
                    
                    guard let dictionary = json as? [String: Any],
                        let genres = dictionary["genres"] as? [[String: Any]] else {
                            print("Error creating dictionary")
                            return
                    }
                    
                    for genre in genres {
                        guard let id = (genre["id"] as? Int?) ?? 0,
                            let name = (genre["name"] as? String?) ?? "" else {
                                print("Error creating genre")
                                return
                        }
                        self?.genresList[id.description] = name
                    }
                    completion(true)
                } catch {
                    print("Error parsing JSON Object")
                    completion(false)
                }
            case .failure:
                print("Error getting genres")
                completion(false)
            }
        })
    }
}
