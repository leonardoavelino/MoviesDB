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
    var isRequesting = false
    
    override lazy var refreshControl: UIRefreshControl? = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.lightGray
        
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.addSubview(self.refreshControl!)
        loadMovies(refreshing: false)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadMovies(refreshing: true)
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailViewController {
            let selectedRow = tableView.indexPathForSelectedRow!.row
            destination.movieDetailViewModel.setup(using: movieViewModel.movies[selectedRow])
        }
    }
    
    func loadMovies(refreshing: Bool) {
        isRequesting = true
        movieViewModel.getMovies(url: Constants.tmdbMoviesBaseUrl + Constants.tmdbApiKey, isRefresh: refreshing, completion: {
            self.tableView.reloadData()
            self.isRequesting = false
        })
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieTableViewCell else {
            print("Couldn't create cell")
            fatalError("Couldn't create cell")
        }
        if movieViewModel.movies.count > 0 {
            cell.setup(using: movieViewModel.movies[indexPath.row])
        }        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height * 1.2 {
            if !isRequesting {
                loadMovies(refreshing: false)
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("MovieListSize \(movieViewModel.movies.count)")
        return movieViewModel.movies.count
    }

    
}

