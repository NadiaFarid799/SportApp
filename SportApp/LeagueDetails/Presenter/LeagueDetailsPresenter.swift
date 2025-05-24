//
//  LeagueDetailsPresenter.swift
//  SportApp
//
//  Created by NadiaFarid on 17/05/2025.

import Foundation
import Alamofire


class LeaguePresenter: LeaguePresenterProtocol {
    
    private let leagueService: LeagueService
    private weak var view: LeagueDetailsViewProtocol?
    
    init(view: LeagueDetailsViewProtocol, service: LeagueService = LeagueService()) {
        self.view = view
        self.leagueService = service
    }
    
    func getUpcomingEvents(leagueId: String,sportName:String) {
        leagueService.fetchUpcomingEvents(leagueId: leagueId,sportName: sportName) { [weak self] result in
            switch result {
            case .success(let events):
                self?.view?.showUpcomingEvents(events)
                print("up\(events)")

            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
    
    func getLatestEvents(leagueId: String,sportName:String) {
        leagueService.fetchLatestEvents(leagueId: leagueId,sportName: sportName) { [weak self] result in
            switch result {
            case .success(let events):
                self?.view?.showLatestEvents(events)
                print("latetet\(events)")
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
    
    func getTeams(leagueId: String,sportName:String) {
        leagueService.fetchTeams(leagueId: leagueId,sportName: sportName) { [weak self] result in
            switch result {
            case .success(let teams):
                self?.view?.showTeams(teams)
                print("teams\(teams)")

            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
}


