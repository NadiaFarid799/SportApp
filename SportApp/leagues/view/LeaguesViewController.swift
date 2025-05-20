//
//  LeaguesViewController.swift
//  SportApp
//
//  Created by Macos on 19/05/2025.
//

import UIKit

class LeaguesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var sportName: String?
    var remoteService: RemoteService?
    var leagues : [League] = []
    
    @IBOutlet weak var leaguesTableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //MARK: configure the tableView
        leaguesTableView.dataSource = self
        leaguesTableView.delegate = self
        
        //MARK: load the League cell NibFile
        let nib = UINib(nibName: "LeaguesViewCell", bundle: nil)
        self.leaguesTableView.register(nib, forCellReuseIdentifier: "leagueCell")
        
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
                self.leagues = response.result
                self.leaguesTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leagues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as? LeaguesViewCell else {
            print("not detected")
            return LeaguesViewCell()
        }
        
        let league = leagues[indexPath.row]
        
        cell.leagueName.text = league.league_name
        cell.leagueCountry.text = league.country_name
        
        
        return cell
    }
    

}
