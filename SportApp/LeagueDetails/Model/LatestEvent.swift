//
//  LatestEvent.swift
//  SportApp
//
//  Created by NadiaFarid on 19/05/2025.
//

import Foundation

import Foundation
struct LatestEventResponse: Codable {
    let success: Int
    let result: [LatestEvents]
}

// MARK: - Event Model
struct LatestEvents: Codable {
    let league_name :String?
    let event_key: String?
    let event_date: String?
    let event_time: String?
    let event_home_team: String?
    let event_away_team: String?
    let event_final_result: String?
    let home_team_logo: String?
    let away_team_logo: String?
}
