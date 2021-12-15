//
//  NetworkServiceProvider.swift
//  MovieBrowser
//
//  Created by Jason Goodney on 12/11/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import UIKit

protocol NetworkServiceProvider {
    var session: URLSession { get set }
    var decoder: JSONDecoder { get set }
    
    func request<T: Codable>(_ decodeType: T.Type, path: MovieDBApiPath, queryItems: [URLQueryItem], completionHandler: @escaping (Result<T, NetworkError>) -> Void)
    func downloadImage(_ path: String, width: String) -> UIImage?
}

extension NetworkServiceProvider {
    func downloadImage(_ path: String, width: String = "w500") -> UIImage? {
        downloadImage(path, width: width)
    }
}
