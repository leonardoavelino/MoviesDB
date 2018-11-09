//
//  ViewController.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 07/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var movieViewModel = MovieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMovies()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        tableView.reloadData()
    }
    
    func loadMovies() {
        movieViewModel.getMovies(url: Constants.tmdbMoviesBaseUrl + Constants.tmdbApiKey)
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieTableViewCell else {
            print("Couldn't create cell")
            fatalError("Couldn't create cell")
        }
        if movieViewModel.movies.count > 0 {
            cell.setup(name: movieViewModel.movies[indexPath.row].name)
        }        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.movies.count
    }

    
}

