//
//  LeagueDetailsViewProtocal.swift
//  SportApp
//
//  Created by NadiaFarid on 17/05/2025.
//

import Foundation



protocol LeagueDetailsViewProtocol: AnyObject {
    func showUpcomingEvents(_ events: [Event])
    func showLatestEvents(_ events: [Event])
    func showTeams(_ teams: [Team])
    func showError(_ error: String)
}

protocol LeaguePresenterProtocol {
    func getUpcomingEvents(leagueId: String,sportName:String)
    func getLatestEvents(leagueId: String,sportName:String)
    func getTeams(leagueId: String,sportName:String)
}
