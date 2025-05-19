//
//  LeagueService.swift
//  SportApp
//
//  Created by Macos on 19/05/2025.
//

import Foundation
import Alamofire

class LeagueService : RemoteService {
    
    func fetchData<T: Codable>(url: URL, completion: @escaping (Result<T,Error>) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { response in
                switch response.result {
                    case .success(let decodedData):
                        completion(.success(decodedData))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    func prepareURL(sportname: String) -> URL {
        let urlString = "https://apiv2.allsportsapi.com/\(sportname.lowercased())/?met=Leagues&APIkey=\(apiKey)"
        
        let url = URL(string: urlString)
        
        return url!
    }
    
}
