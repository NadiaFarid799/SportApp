//
//  MockRemoteService.swift
//  SportAppTests
//
//  Created by Macos on 24/05/2025.
//

import Foundation
@testable import SportApp

class MockRemoteService: RemoteService {
    var preparedURL: URL = URL(string: "https://mock-url.com")!
    var shouldSucceed = true
    var mockLeagues: [League] = []

    func fetchData<T>(url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        if shouldSucceed {
            let response = LeagueResponse(success: 1, result: mockLeagues)
            completion(.success(response as! T))
        } else {
            completion(.failure(NSError(domain: "NetworkError", code: 1)))
        }
    }

    func prepareURL(sportname: String) -> URL {
        return preparedURL
    }
}
