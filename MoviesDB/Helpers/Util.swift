//
//  Util.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 10/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

/// Helper class to parse dates and decode genres.
class Util {

    /// Singleton of the Util class.
    static let shared = Util()

    /// Parses a date depending of the view that will show it.
    ///
    /// - Parameters:
    ///   - toDetail: Used te decide to parse the date detailed or just return the year.
    ///   - date: The date to be parsed.
    /// - Returns: The date parsed.
    func parseDate(toDetail: Bool, date: String) -> String {
        if toDetail {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
            if let date = dateFormatter.date(from: date) {
                dateFormatter.dateFormat = "MMMM dd, yyyy"
                dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                let timeStamp = dateFormatter.string(from: date)

                return timeStamp
            } else {
                return Bundle.main.localizedString(forKey: "no_date", value: nil, table: "Default")
            }
        } else {
            return String(date.prefix(4))
        }
    }

    /// Decodes genres to strings from a list of ids.
    ///
    /// - Parameter genre_ids: The genre ids list to be decoded.
    /// - Returns: A full String containing all genres.
    func decodeGenres(genre_ids: [Int]) -> String {
        var genres: String = ""

        for (index, id) in genre_ids.enumerated() {
            if let genre = MoviesService.shared.genresList[id.description] {
                genres.append(genre)
                if index < genre_ids.count - 1 {
                    genres.append(", ")
                }
            }
        }
        return genres
    }

    /// Creates and returns a alert controller.
    ///
    /// - Parameters:
    ///   - title: The alert title.
    ///   - message: The alert message.
    /// - Returns: The alert controller.
    func createAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))

        return alert
    }
}

/// Struct to check connectivity
struct Connectivity {

    /// Alamofire network manager
    static let sharedInstance = NetworkReachabilityManager()!

    /// Checks for internet connection
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}
