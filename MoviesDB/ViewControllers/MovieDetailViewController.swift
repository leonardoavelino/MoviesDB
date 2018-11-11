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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        let url = URL(string: Constants.tmdbBackdropImageBaseUrl + movieDetailViewModel.movie.backdrop)
        self.backdrop.sd_setImage(with: url, completed: { (image, error, cacheType, imageURL) in
            if error != nil {
                let urlPoster = URL(string: Constants.tmdbOriginalImageBaseUrl + self.movieDetailViewModel.movie.poster)
                self.backdrop.sd_setImage(with: urlPoster, completed: nil)
            }
        })
        
        var genres: String = ""
        
        for (index, id) in movieDetailViewModel.movie.genre_ids.enumerated() {
            genres.append(MoviesService.shared.genresList[id.description]!)
            if index < movieDetailViewModel.movie.genre_ids.count - 1 {
                genres.append(", ")
            }
        }
        
        self.name.text = movieDetailViewModel.movie.name
        self.genre.text = genres
        self.overview.text = movieDetailViewModel.movie.overview
        self.releaseDate.text = movieDetailViewModel.movie.releaseDate
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
