//
//  SampleAppTests.swift
//  SampleAppTests
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import XCTest
@testable import MovieBrowser

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}

class URLSessionMock: URLSession {
    
    var data: Data?
    var error: Error?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        
        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}

class SampleAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNetworkRequest_Success() {
        let session = URLSessionMock()
        let networkService = Network(session: session)
        
        let mock = Movie(id: 1, title: "Dummy Movie", voteAverage: 8.3, releaseDate: "12/25/21", posterPath: "/abcd.jpg", overview: "")
        
        do {
            let data = try JSONEncoder().encode(mock)
            session.data = data
        } catch {
            XCTFail("Failed to encoded category")
        }
        
        var resultMovie: Movie?
        
        networkService.request(Movie.self, path: .search, queryItems: []) { result in
            resultMovie = try? result.get()
        }
        
        XCTAssertEqual(resultMovie, mock)
    }

    func testNetworkRequest_Fail() {
        let session = URLSessionMock()
        let networkService = Network(session: session)
        
        let mockError = NetworkError.unknown(message: "Mock Error")
        session.error = mockError
        
        var resultError: NetworkError?
        
        networkService.request(Movie.self, path: .search, queryItems: []) { result in
            switch result {
            case .success(_):
                XCTFail("Not expected to succeed")
            case .failure(let error):
                resultError = error
            }
        }
        
        XCTAssertEqual(resultError?.localizedDescription, mockError.localizedDescription)
        
    }

}

extension Movie: Equatable {
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}
