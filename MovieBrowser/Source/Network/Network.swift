//
//  Network.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class Network: NetworkServiceProvider {
    let apiKey = "5885c445eab51c7004916b9c0313e2d3"

    var session: URLSession
    var decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func request<T>(_ decodeType: T.Type, path: MovieDBApiPath, queryItems: [URLQueryItem], completionHandler: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/\(path.rawValue)"
        
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: apiKey)
        components.queryItems = [apiKeyQueryItem] + queryItems
        
        guard let endpoint = components.url else {
            completionHandler(.failure(.invalidURL(message: "Bad url components url")))
            return
        }
        
        session.dataTask(with: endpoint) { data, response, error in
            if let error = error as? NetworkError {
                completionHandler(.failure(error))
                return
            }
            
            do {
                let result = try self.decoder.decode(decodeType, from: data!)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(.decoding(message: error.localizedDescription)))
            }
        }
        .resume()
    }
    
    func downloadImage(_ path: String, width: String = "w500") -> UIImage? {
        let imageURL = buildImageURL(path, width: width)
        
        do {
            let imagedData = try Data(contentsOf: imageURL)
            return UIImage(data: imagedData)
        } catch {
            print("error getting contents of url", error.localizedDescription)
            return nil
        }
    }
    
    private func buildImageURL(_ path: String, width: String) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/\(width)/\(path)")!
    }
}
