//
//  ViewController.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 07/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import UIKit


/// The Movies List ViewController
class MovieListViewController: UITableViewController, UISearchBarDelegate {

    /// The Movies List ViewModel
    var movieListViewModel = MovieListViewModel()

    /// Controls the flow of requests to not request more than needed.
    var isRequesting = false

    /// The searchBar element.
    @IBOutlet weak var searchBar: UISearchBar!

    /// The refreshControl element.
    override lazy var refreshControl: UIRefreshControl? = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(MovieListViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.lightGray
        
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()        
        self.initialLoading()
    }

    /// Setups refresh control and search bar on tableView.
    func setupTableView() {
        self.tableView.addSubview(self.refreshControl!)
        self.searchBar.delegate = self
    }

    /// Fetches for genres and movies on load.
    func initialLoading() {
        MoviesService.shared.getGenres(completion: { [weak self] success in
            if success {
                self?.loadMovies(refreshing: false)
            }
        })
    }

    /// Handles the pull to refresh function.
    ///
    /// - Parameter refreshControl: The refresh control to handle.
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadMovies(refreshing: true)
        refreshControl.endRefreshing()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailViewController {
            let selectedRow = tableView.indexPathForSelectedRow!.row
            destination.movieDetailViewModel.setup(using: movieListViewModel.movies[selectedRow])
        }
    }

    /// Handles the click on the keyboard button to search.
    ///
    /// - Parameter searchBar: The search bar element.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        loadMovies(refreshing: true)
    }

    /// Handles the click on search bar cancel button.
    ///
    /// - Parameter searchBar: The search bar element.
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        self.searchBar.text = ""
        loadMovies(refreshing: true)
    }

    /// Loads movies also reloads tableView.
    ///
    /// - Parameter refreshing: Used to decide if the tableView must be cleared.
    func loadMovies(refreshing: Bool) {
        if movieListViewModel.currentPage + 1 > movieListViewModel.totalPages && !refreshing || MoviesService.shared.genresList.isEmpty {
            return
        }
        isRequesting = true
        var query: String? = nil
        if !(searchBar.text?.isEmpty)! {
            query = self.searchBar.text
        }
        movieListViewModel.getMovies(isRefresh: refreshing, query: query, completion: { [weak self] success in
            if success {
                self?.tableView.reloadData()
                self?.isRequesting = false
            }
        })
    }
}

// MARK: TableView functions.

extension MovieListViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        if movieListViewModel.movies.count > 0 {
            cell.setup(using: movieListViewModel.movies[indexPath.row])
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
        return movieListViewModel.movies.count
    }
}

