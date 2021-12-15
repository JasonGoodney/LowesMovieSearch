//
//  Movie.swift
//  MovieBrowser
//
//  Created by Jason Goodney on 12/11/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct MovieDBRoot: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let voteAverage: Double
    let releaseDate: String
    let posterPath: String?
    let overview: String
}
