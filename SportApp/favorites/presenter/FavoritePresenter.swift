//
//  FavoritePresenter.swift
//  SportApp
//
//  Created by Macos on 23/05/2025.
//

import Foundation

class FavoritePresenter{
    
    var localSource: LocalSource
    var favoriteViewContract: FavoriteViewContract
    
    init(localSource: LocalSource, favoriteViewContract: FavoriteViewContract) {
        self.localSource = localSource
        self.favoriteViewContract = favoriteViewContract
    }
    
    func getLocalLeagues(){
        
        let leagues = localSource.getLeagues()
        
        guard let leagues = leagues else {
            return
        }
        
        favoriteViewContract.updateLeagues(leagues: leagues)
    }
    
    func deleteLeague(league: LocalLeague){
        localSource.removeLeague(league: league)
    }
    
}
