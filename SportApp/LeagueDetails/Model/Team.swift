//
//  Team.swift
//  SportApp
//
//  Created by NadiaFarid on 17/05/2025.
//

import Foundation
//struct Team: Codable {
//    let idTeam: String?
//    let strTeam: String?
//    let strTeamBadge: String?
//}

struct TeamResponse: Codable {
    let result: [Team]?
}

struct Team: Codable {
    let team_key: Int
    let team_name: String
    let team_logo: String?
}
