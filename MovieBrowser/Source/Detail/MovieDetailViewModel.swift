//
//  MovieDetailViewModel.swift
//  MovieBrowser
//
//  Created by Jason Goodney on 12/14/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewModel {
    
    var movie: Movie
    private let networkService: NetworkServiceProvider
    
    init(movie: Movie, networkService: NetworkServiceProvider = Network()) {
        self.movie = movie
        self.networkService = networkService
    }
    
    func downloadPoster() -> UIImage? {
        guard let posterPath = movie.posterPath else { return nil }
        return networkService.downloadImage(posterPath)
    }
}
