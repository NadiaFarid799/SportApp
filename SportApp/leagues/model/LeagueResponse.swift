//
//  File.swift
//  SportApp
//
//  Created by Macos on 18/05/2025.
//

import Foundation

struct LeagueResponse : Codable {
    let success: Int
    var result: [League]
}
