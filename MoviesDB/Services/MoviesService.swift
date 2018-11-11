//
//  MoviesService.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 08/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import Foundation
import Alamofire

class MoviesService {
    static let shared = MoviesService()
    
    var genresList: [String: String] = [:]
    
    func getMovies(page: Int, query: String?, completion: @escaping (DataResponse<Any>)->()) {
        
        var queryString = Constants.tmdbMoviesBaseUrl + Constants.tmdbApiKey +
            Constants.pageParameter + page.description
        
        if let query = query {
            queryString = Constants.tmdbSearchMoviesBaseUrl + Constants.tmdbApiKey +
                Constants.pageParameter + page.description + Constants.queryParameter + query
        }
        print("QueryString \(queryString)")
        Alamofire.request(queryString).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success:
                completion(response)
            case .failure:
                print("Error getting movies data")
            }
        })
    }
    
    func getGenres(completion: @escaping () -> ()) {
        Alamofire.request(Constants.genresBaseUrl +
            Constants.tmdbApiKey).responseJSON(completionHandler: { (response) in
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
                        self.genresList[id.description] = name
                    }
                    completion()
                } catch {
                    print("Error parsing JSON Object")
                }
            case .failure:
                print("Error getting genres")
            }
        })
    }
}
