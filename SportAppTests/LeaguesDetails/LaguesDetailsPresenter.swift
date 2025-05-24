//
//  LaguesDetailsPresenter.swift
//  SportAppTests
//
//  Created by NadiaFarid on 24/05/2025.
//

import Foundation

@testable import SportApp
class LeaguesDetailsPresenter : LeaguePresenterProtocol {
    weak var view: LeagueDetailsViewProtocol?
    let service: MockaRemoteServices
    
    init(view: LeagueDetailsViewProtocol, service: MockaRemoteServices) {
        self.view = view
        self.service = service
    }
    
    
    
    func getUpcomingEvents(leagueId: String, sportName: String) {
        service.fetchUpcomingEvents(leagueId: leagueId, sportName: sportName) { [weak self] result in
            switch result {
            case .success(let events):
                self?.view?.showUpcomingEvents(events)
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
    
    func getLatestEvents(leagueId: String, sportName: String) {
        service.fetchLatestEvents(leagueId: leagueId, sportName: sportName) { [weak self] result in
            switch result {
            case .success(let events):
                self?.view?.showLatestEvents(events)
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
    
    func getTeams(leagueId: String, sportName: String) {
        service.fetchTeams(leagueId: leagueId, sportName: sportName) { [weak self] result in
            switch result {
            case .success(let teams):
                self?.view?.showTeams(teams)
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
}
