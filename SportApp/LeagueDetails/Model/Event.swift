//
//  Event.swift
//  SportApp
//
//  Created by NadiaFarid on 17/05/2025.
//

import Foundation
//struct Event: Codable {
//    let idEvent: String?
//    let strEvent: String?
//    let dateEvent: String?
//    let strTime: String?
//    let strThumb: String?
//    let strHomeTeam: String?
//    let strAwayTeam: String?
//    let intHomeScore: String?
//    let intAwayScore: String?
//    
//}


struct Event: Codable {
    let event_key: Int
    let event_date: String
    let event_time: String
    let event_home_team: String
    let event_away_team: String
    let event_ft_result: String?
    let home_team_logo: String?
    let away_team_logo: String?
    let event_stadium: String?
}
struct EventResponse: Codable {
    let result: [Event]
}
