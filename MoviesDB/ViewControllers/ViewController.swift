//
//  ViewController.swift
//  MoviesDB
//
//  Created by Leonardo Avelino on 07/11/18.
//  Copyright © 2018 Leonardo Avelino. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {
    
    var movieViewModel = MovieViewModel()
    var isRequesting = false
    var isSearching = false
    @IBOutlet weak var searchBar: UISearchBar!
    
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
        self.setupTableView()        
        self.initialLoading()
    }
    
    func setupTableView() {
        self.tableView.addSubview(self.refreshControl!)
        self.searchBar.delegate = self
    }
    
    func initialLoading() {
        MoviesService.shared.getGenres(completion: {
            self.loadMovies(refreshing: false)
        })
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadMovies(refreshing: true)
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailViewController {
            let selectedRow = tableView.indexPathForSelectedRow!.row
            destination.movieDetailViewModel.setup(using: movieViewModel.movies[selectedRow])
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieViewModel.getMovies(isRefresh: true, query: searchBar.text, completion: {
            self.tableView.reloadData()
            self.searchBar.endEditing(true)
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        self.searchBar.text = ""
        loadMovies(refreshing: true)
        self.tableView.reloadData()
    }
    
    func loadMovies(refreshing: Bool) {
        if movieViewModel.actualPage > movieViewModel.totalPages && !refreshing {
            return
        }
        isRequesting = true
        var query: String? = nil
        if !(searchBar.text?.isEmpty)! {
            query = self.searchBar.text
        }
        movieViewModel.getMovies(isRefresh: refreshing, query: query, completion: {
            self.tableView.reloadData()
            self.isRequesting = false
        })
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        
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
        return movieViewModel.movies.count
    }
}

