//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        navigationItem.title = "Movie Search"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        performSearch()
    }
    
    private func performSearch() {
        viewModel.movies = []
        tableView.reloadData()
        
        viewModel.searchMovies() { [self] success in
            if success {
                DispatchQueue.main.async { [self] in
                    tableView.reloadData()
                }
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = viewModel.movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        
        let movieDetailViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: MovieDetailViewController.storyboardIdentifier, creator: { coder -> MovieDetailViewController? in
            let movieDetailViewModel = MovieDetailViewModel(movie: movie)
            return MovieDetailViewController(coder: coder, viewModel: movieDetailViewModel)
        })
        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movies.count - 3 {
            performSearch()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchQuery = searchText
        
        if searchText.isEmpty {
            tableView.reloadData()
        }
        
        searchButton.isEnabled = !searchText.isEmpty
        searchButton.setTitleColor(searchText.isEmpty ? .lightGray : .systemBlue, for: .normal)
    }
}
