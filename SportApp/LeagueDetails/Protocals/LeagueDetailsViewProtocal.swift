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
    func showError(_ message: String)
}

//protocol LeagueDetailsViewProtocol: AnyObject {
//    func showUpcomingEvents(_ events: [Event])
//    func showLatestEvents(_ events: [Event])
//    func showTeams(_ teams: [Team])
//    func showError(_ message: String)
//}
//protocol LeagueDetailsPresenterProtocol {
//    func fetchDetails(forLeagueId id: String)
//}
