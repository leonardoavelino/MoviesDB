//
//  MovieTableViewCell.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 07/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(using movie: Movie) {
        let url = URL(string: Constants.tmdbImageBaseUrl + movie.poster)
        self.name.text = movie.name
        
        var genres: String = ""
        
        for (index, id) in movie.genre_ids.enumerated() {
            genres.append(MoviesService.shared.genresList[id.description]!)
            if index < movie.genre_ids.count - 1 {
                genres.append(", ")
            }
        }
        
        self.genre.text = genres
        self.releaseDate.text = movie.releaseDate
        
        self.poster.sd_setImage(with: url, completed: nil)
    }

}
