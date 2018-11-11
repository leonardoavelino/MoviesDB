//
//  MovieViewModel.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 08/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import Foundation

/// The MovieViewModel.
class MovieViewModel {
    
    /// The Movies list.
    var movies: [Movie] = []
    
    /// The current showing page.
    var currentPage: Int = 0

    /// The total number of pages that can be displayed.
    var totalPages: Int = 1

    /// Fetchs movies from tmdb and updates the movies list. If query is not nil, it will return a search result.
    ///
    /// - Parameters:
    ///   - isRefresh: Used to resfresh or not the movies tableView datasource.
    ///   - query: Query parameter to search for specific movies.
    ///   - completion: Called when the movies list was updated. True if the request was successful, false otherwise.
    func getMovies(isRefresh: Bool, query: String?, completion: @escaping (Bool) -> Void) {
        if isRefresh {
            movies.removeAll()
            currentPage = 0
        }
        MoviesService.shared.getMovies(page: currentPage + 1, query: query, completion: { [weak self] movies, page, pages in
            if let page = page {
                self?.currentPage = page
                self?.totalPages = pages!
                self?.movies.append(contentsOf: movies)
                completion(true)
            } else {
                completion(false)
            }
        })
    }
}
