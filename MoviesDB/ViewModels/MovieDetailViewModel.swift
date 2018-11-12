//
//  MovieDetailViewModel.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 09/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import Foundation

/// The MovieDetailViewModel.
class MovieDetailViewModel {
    
    /// The Movie object to populate the view.
    var movie: Movie = Movie()
    
    /// Setups the Movie object.
    ///
    /// - Parameter movie: The movie object to be setted.
    func setup(using movie: Movie) {
        self.movie = movie
    }
    
}
