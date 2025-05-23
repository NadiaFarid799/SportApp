//
//  FavoritePresenter.swift
//  SportApp
//
//  Created by Macos on 23/05/2025.
//

import Foundation
import Reachability

class FavoritePresenter{
    
    var localSource: LocalSource
    var favoriteViewContract: FavoriteViewContract
    var reachability: Reachability?
    
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
    
    func onSelectCell() {
        
        reachability = try? Reachability()
    
        reachability?.whenUnreachable = { reach in
            print("unreachable")
            self.favoriteViewContract.fireConnectionAlert()
        }

        reachability?.whenReachable = { reach in
            print("reachable")
            self.favoriteViewContract.naviagateToLeagues()
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
}
