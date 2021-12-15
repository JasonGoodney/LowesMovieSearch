//
//  SearchViewModel.swift
//  MovieBrowser
//
//  Created by Jason Goodney on 12/14/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

class SearchViewModel {
    var searchQuery = "" {
        didSet {
            currentPage = 0
            
            if searchQuery.isEmpty {
                movies = []
            }
        }
    }
    
    var movies: [Movie] = []
    private let networkService: NetworkServiceProvider
    
    private var currentPage = 0
    private let batchSize = 20
    private var canLoadMore = true
    
    init(networkService: NetworkServiceProvider = Network(decoder: JSONDecoder(keyDecodingStrategy: .convertFromSnakeCase))) {
        self.networkService = networkService
    }
    
    func searchMovies(completionHandler: @escaping (Bool) -> Void) {
        guard canLoadMore else { return }
        currentPage += 1
        
        let queryItems = [
            URLQueryItem(name: "query", value: searchQuery),
            URLQueryItem(name: "page", value: String(currentPage))
        ]
        
        networkService.request(MovieDBRoot.self, path: .search, queryItems: queryItems) { [weak self] result in
            switch result {
            case .success(let root):
                guard let self = self else { return }
                if root.results.count < self.batchSize { self.canLoadMore = false }
                self.movies.append(contentsOf: root.results)
                completionHandler(true)
                
            case .failure(let error):
                print(error)
                completionHandler(false)
            }
        }
    }
}
