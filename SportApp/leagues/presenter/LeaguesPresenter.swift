//
//  LeaguesPresenter.swift
//  SportApp
//
//  Created by Macos on 20/05/2025.
//

import Foundation

class LeaguesPresenter{
    
    var leagueViewContract: LeagueViewContract
    var remoteService: RemoteService
    
    init(leagueViewContract: LeagueViewContract, remoteService: RemoteService) {
        self.leagueViewContract = leagueViewContract
        self.remoteService = remoteService
    }
    
    func getLeagues(sportName: String){
        let leaguesUrl = remoteService.prepareURL(sportname: sportName)
        
        remoteService.fetchData(url: leaguesUrl) { (result: Result<LeagueResponse,Error>) in
            switch result {
            case .success(let response):
                self.leagueViewContract.updateLeagues(leagues: response.result)
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
