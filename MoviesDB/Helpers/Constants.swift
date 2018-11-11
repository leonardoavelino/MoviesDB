//
//  Constants.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 08/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import Foundation

/// The constants struct.
struct Constants {
    
    /// The poster image base url.
    static var tmdbPosterImageBaseUrl = "https://image.tmdb.org/t/p/w154"
    
    /// The backdrop image base url.
    static var tmdbBackdropImageBaseUrl = "https://image.tmdb.org/t/p/w780"
    
    /// The original quality image base url.
    static var tmdbOriginalImageBaseUrl = "https://image.tmdb.org/t/p/original"
    
    /// The page parameter.
    static let pageParameter = "&page="
    
    /// The query parameter.
    static let queryParameter = "&query="

    /// The ordering parameter.
    static let orderParameter = "&sort_by=release_date.desc"
    
    /// The global tmdb API KEY.
    static let tmdbApiKey: String = "1f54bd990f1cdfb230adb312546d765d"
    
    /// The movies base url.
    static let tmdbMoviesBaseUrl: String = "https://api.themoviedb.org/3/discover/movie?api_key="
    
    /// The search for specific movies base url.
    static let tmdbSearchMoviesBaseUrl: String = "https://api.themoviedb.org/3/search/movie?api_key="
    
    /// The genres base url.
    static let genresBaseUrl = "https://api.themoviedb.org/3/genre/movie/list?api_key="
    
}
