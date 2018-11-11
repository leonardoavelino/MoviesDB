//
//  MovieDetailViewController.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 09/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {
    
    var movieDetailViewModel = MovieDetailViewModel()
    
    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var releaseDate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    override func viewDidLayoutSubviews() {
        self.overview.setContentOffset(.zero, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadData() {
        let url = URL(string: Constants.tmdbBackdropImageBaseUrl + movieDetailViewModel.movie.backdrop)
        self.backdrop.sd_setImage(with: url, completed: { [weak self] (image, error, cacheType, imageURL) in
            if error != nil {
                let urlPoster = URL(string: Constants.tmdbOriginalImageBaseUrl + (self?.movieDetailViewModel.movie.poster)!)
                self?.backdrop.sd_setImage(with: urlPoster, completed: nil)
            }
        })
        
        self.name.text = movieDetailViewModel.movie.name
        self.genre.text = Util.shared.decodeGenres(genre_ids: movieDetailViewModel.movie.genre_ids)
        self.overview.text = movieDetailViewModel.movie.overview
        self.releaseDate.text = Util.shared.parseDate(toDetail: true, date: movieDetailViewModel.movie.releaseDate)
    }
}
