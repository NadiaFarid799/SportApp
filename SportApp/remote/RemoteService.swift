//
//  RemoteService.swift
//  SportApp
//
//  Created by Macos on 19/05/2025.
//

import Foundation

protocol RemoteService {
    
    func fetchData<T: Codable>(
        url: URL,completion: @escaping(Result<T,Error>) -> Void)
    
    func prepareURL(sportname: String) -> URL


    
    
    
}
