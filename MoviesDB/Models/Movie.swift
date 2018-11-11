//
//  Movie.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 08/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import Foundation

/// The Movie model containing its main information.
class Movie {
    
    /// The Movie title name.
    var name: String = ""

    /// The portion of the Movie poster image url.
    var poster: String = ""

    /// The portion of the Movie backdrop image url.
    var backdrop: String = ""

    /// The Movie genre ids list.
    var genre_ids: [Int] = []

    /// The Movie overview description.
    var overview: String = ""

    /// The Movie release date.
    var releaseDate: String = ""

}
