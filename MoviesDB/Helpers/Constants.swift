//
//  Constants.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 08/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import Foundation

struct Constants {
    
    static let tmdbConfigurationUrl = "https://api.themoviedb.org/3/configuration?api_key="
    
    static var tmdbPosterImageBaseUrl = "https://image.tmdb.org/t/p/w154"
    
    static var tmdbBackdropImageBaseUrl = "https://image.tmdb.org/t/p/w780"
    
    static var tmdbOriginalImageBaseUrl = "https://image.tmdb.org/t/p/original"
    
    static let pageParameter = "&page="
    
    static let queryParameter = "&query="
    
    static let tmdbApiKey: String = "1f54bd990f1cdfb230adb312546d765d"
    
    static let tmdbMoviesBaseUrl: String = "https://api.themoviedb.org/3/discover/movie?api_key="
    
    static let tmdbSearchMoviesBaseUrl: String = "https://api.themoviedb.org/3/search/movie?api_key="
    
    static let genresBaseUrl = "https://api.themoviedb.org/3/genre/movie/list?api_key="
    
}
