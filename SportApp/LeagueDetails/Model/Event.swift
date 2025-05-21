//
//  Event.swift
//  SportApp
//
//  Created by NadiaFarid on 17/05/2025.
//

import Foundation

struct Event: Codable {
    let event_key : Int?
    let event_date: String?
    let event_time: String?
    let event_home_team: String?
    let home_team_key: Int?
    let event_away_team: String?
    let away_team_key: Int?
    let event_halftime_result: String?
    let league_logo: String?
    let home_team_logo: String?
    let away_team_logo: String?
    let league_key: Int?
    let league_name: String?
    let event_stadium: String?
    let league_season: String?
    let event_final_result: String?

}

struct EventResponse: Codable{
     let success: Int?

    let result: [Event]?
}


struct Lineups: Decodable {
    let homeTeam: TeamLineup?
    let awayTeam: TeamLineup?
    
    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }
}

struct TeamLineup: Decodable {
    let startingLineups: [Player]
    let substitutes: [Player]
    let coaches: [Coach]
    let missingPlayers: [String]
    
    enum CodingKeys: String, CodingKey {
        case startingLineups = "starting_lineups"
        case substitutes
        case coaches
        case missingPlayers = "missing_players"
    }
}

struct Player: Decodable {
    
}

struct Coach: Decodable {
    let coache: String?
    let coacheCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case coache
        case coacheCountry = "coache_country"
    }
}

struct Statistic: Decodable {
    let type: String
    let home: String
    let away: String
}
