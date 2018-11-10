//
//  MovieDetailViewModel.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 09/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
    
    var movie: Movie = Movie()
    
    func setup(using movie: Movie) {
        self.movie = movie
    }
    
}
