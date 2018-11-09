//
//  MoviesService.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 08/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class MoviesService {
    static let shared = MoviesService()
    
    func getMovies(url: String, completion: @escaping (DataResponse<Any>)->()) {
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success:
                completion(response)
            case .failure:
                print("erro")
            }
        })
    }
    
}
