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


///ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOCZpwXLRKrFSBLaDe3lwfcyA2Kv83cx+zJ3t4JxvX/9 your_email@example.com
