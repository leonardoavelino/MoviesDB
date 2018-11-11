//
//  MovieDetailViewController.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 09/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import UIKit
import SDWebImage

/// The movie detail ViewController
class MovieDetailViewController: UIViewController {

    /// The movie detail ViewModel
    var movieDetailViewModel = MovieDetailViewModel()

    /// The backdrop imageView element.
    @IBOutlet weak var backdrop: UIImageView!

    /// The movie name label element.
    @IBOutlet weak var name: UILabel!

    /// The movie genre label element.
    @IBOutlet weak var genre: UILabel!

    /// The movie overview description textView element.
    @IBOutlet weak var overview: UITextView!

    /// The movie release date label element.
    @IBOutlet weak var releaseDate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }

    override func viewDidLayoutSubviews() {
        /// Used to scroll up to top the textView element.
        self.overview.setContentOffset(.zero, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /// Fills fields with the movie informations.
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
