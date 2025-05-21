//
//  LeaguesDetailsServices.swift
//  SportApp
//
//  Created by NadiaFarid on 19/05/2025.
//

import Foundation
import Alamofire
class LeguesDetailsServices : LeagueService {
    let apiKey = "67b9bf30f793d80b7fbe6a17e67804332ea9f0399c9d9f66ae7da6aa2cb9f346"
    
    
    override func fetchData<T: Codable>(url: URL, completion: @escaping (Result<T,Error>) -> Void) {
        AF
        .request(url).responseDecodable(of: T.self) { response in
                switch response.result {
                    case .success(let decodedData):
                        completion(.success(decodedData))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    override func prepareURL(sportname: String) -> URL {
        let urlString = " https://apiv2.allsportsapi.com/football/?met=Livescore&APIkey= 67b9bf30f793d80b7fbe6a17e67804332ea9f0399c9d9f66ae7da6aa2cb9f346"
        
        let url = URL(string: urlString)
        
        return url!
    }
    
}
