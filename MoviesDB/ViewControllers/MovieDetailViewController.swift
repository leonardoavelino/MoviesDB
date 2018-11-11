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

    /// The movie name element.
    @IBOutlet weak var name: UILabel!

    /// The movie genre element.
    @IBOutlet weak var genre: UILabel!

    /// The movie overview description element.
    @IBOutlet weak var overview: UITextView!

    /// The movie release date element.
    @IBOutlet weak var releaseDate: UILabel!

    /// The genre label.
    @IBOutlet weak var genreLabel: UILabel!

    /// The release date label.
    @IBOutlet weak var releaseDateLabel: UILabel!

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
        self.genreLabel.text = Bundle.main.localizedString(forKey: "genre", value: nil, table: "Default")
        self.releaseDateLabel.text = Bundle.main.localizedString(forKey: "release_date", value: nil, table: "Default")

        let url = URL(string: Constants.tmdbBackdropImageBaseUrl + movieDetailViewModel.movie.backdrop)
        self.backdrop.sd_setImage(with: url, completed: { (image, error, cacheType, imageURL) in
            if error != nil {
                let urlPoster = URL(string: Constants.tmdbPosterImageBaseUrl + (self.movieDetailViewModel.movie.poster))
                self.backdrop.sd_setImage(with: urlPoster, placeholderImage: UIImage(named: "no-image"), options: [], completed: nil)
            }
        })

        self.name.text = movieDetailViewModel.movie.name
        if movieDetailViewModel.movie.genre_ids.count > 0 {
            self.genre.text = Util.shared.decodeGenres(genre_ids: movieDetailViewModel.movie.genre_ids)
        } else {
            self.genre.text = Bundle.main.localizedString(forKey: "no_genre", value: nil, table: "Default")
        }
        self.overview.text = movieDetailViewModel.movie.overview
        self.releaseDate.text = Util.shared.parseDate(toDetail: true, date: movieDetailViewModel.movie.releaseDate)
    }
}
