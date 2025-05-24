//
//  MockLocalSource.swift
//  SportAppTests
//
//  Created by Macos on 24/05/2025.
//

import Foundation
@testable import SportApp

class MockLocalSource: LocalSource {
        var savedLeague: League?
        var savedSportName: String?
        var savedImage: Data?
        
        func saveLeague(league: League, sportName: String, image: Data) {
            savedLeague = league
            savedSportName = sportName
            savedImage = image
        }

        func removeLeague(league: LocalLeague) {}
        func getLeagues() -> [LocalLeague]? { return [] }
        func isLeagueInFavorites(leagueKey: String) -> Bool { return false }
    }
