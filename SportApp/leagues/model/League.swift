//
//  League.swift
//  SportApp
//
//  Created by Macos on 18/05/2025.
//

import Foundation

struct League : Codable {
    let league_key: Int
    let league_name: String
    
    // Optional fields
    let country_key: Int?
    let country_name: String?
    let league_surface: String?
    let league_year: String?
    let league_logo: String?
    let country_logo: String?
}
