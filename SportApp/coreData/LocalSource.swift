//
//  LocalSource.swift
//  SportApp
//
//  Created by Macos on 23/05/2025.
//

import Foundation

protocol LocalSource{
    
    func saveLeague(league: League,sportName: String, image: Data)
    
    func removeLeague(league: LocalLeague)
    
    func getLeagues() -> [LocalLeague]?
    
    func isLeagueInFavorites(leagueKey: Int) -> Bool
}
