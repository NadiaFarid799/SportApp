//
//  LeaguesViewController.swift
//  SportApp
//
//  Created by Macos on 19/05/2025.
//

import UIKit

class LeaguesViewController: UIViewController {
    
    var sportName: String?
    var remoteService: RemoteService?

    override func viewDidLoad(){
        super.viewDidLoad()
        
        // MARK: checking if the sport name sent from previous page is null or not
        guard let sportName = sportName else {
            sportName = "football"
            return
        }
        
        self.title = "\(sportName) Leagues"
        remoteService = LeagueService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // MARK: checking if the sport name sent from previous page is null or not
        guard let sportName = sportName else {
            sportName = "football"
            return
        }
        
        // MARK: Here we prepare the url based on the sport name
        let leaguesUrl = remoteService!.prepareURL(sportname: sportName)
        
        // MARK: Here we hit the Api and receive the data from server
        remoteService!.fetchData(url: leaguesUrl) { (result: Result<LeagueResponse,Error>) in
            switch result {
            case .success(let response):
                print(response.result.count)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    

}
