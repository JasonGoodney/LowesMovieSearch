//
//  NetworkError.swift
//  MovieBrowser
//
//  Created by Jason Goodney on 12/11/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL(message: String)
    case decoding(message: String)
    case unknown(message: String)
}
