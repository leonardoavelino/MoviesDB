//
//  MovieTableViewCell.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 07/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import UIKit
import SDWebImage

/// The custom MovieTableViewCell.
class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Fills cell fields with the movie informations.
    ///
    /// - Parameter movie: The movie to be used to get information to the cell.
    func setup(using movie: Movie) {
        let url = URL(string: Constants.tmdbPosterImageBaseUrl + movie.poster)
        self.name.text = movie.name
        self.genre.text = Util.shared.decodeGenres(genre_ids: movie.genre_ids)
        self.releaseDate.text = Util.shared.parseDate(toDetail: false, date: movie.releaseDate)
        self.poster.sd_setImage(with: url, placeholderImage: UIImage(named: "no-image"), options: [], completed: nil)
    }

}
