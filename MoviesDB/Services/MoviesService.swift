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
    
    func getMovies(url: String, page: Int, completion: @escaping (DataResponse<Any>)->()) {
        Alamofire.request(url + page.description).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success:
                completion(response)
            case .failure:
                print("Error getting movies data")
            }
        })
    }
    
    func getGenres() {
        Alamofire.request(Constants.genresBaseUrl + Constants.tmdbApiKey).responseJSON(completionHandler: { (response) in
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
                } catch {
                    print("Error parsing JSON Object")
                }
            case .failure:
                print("Error getting genres")
            }
        })
    }
}
