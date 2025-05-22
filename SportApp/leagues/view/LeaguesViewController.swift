//
//  LeaguesViewController.swift
//  SportApp
//
//  Created by Macos on 19/05/2025.
//

import UIKit
import SDWebImage

class LeaguesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,LeagueViewContract{
    
    var sportName: String?
    var leagues: [League] = []
    var leaguesViewPresenter: LeaguesPresenter?
    
    @IBOutlet weak var leaguesTableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //MARK: configure the tableView
        leaguesTableView.dataSource = self
        leaguesTableView.delegate = self
        
        //MARK: Initialize Presenter
        leaguesViewPresenter = LeaguesPresenter(leagueViewContract: self, remoteService: LeagueService())
        
        //MARK: load the League cell NibFile
        let nib = UINib(nibName: "LeaguesViewCell", bundle: nil)
        self.leaguesTableView.register(nib, forCellReuseIdentifier: "leagueCell")
        
        self.title = "\(self.sportName!) Leagues"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // MARK: Here we hit the Api and receive the data from server
        leaguesViewPresenter?.getLeagues(sportName: self.sportName!)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leagues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    // MARK: Here we configure our cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as? LeaguesViewCell else {
            print("not detected")
            return LeaguesViewCell()
        }
        
        let league = self.leagues[indexPath.row]
        
        cell.leagueName.text = league.league_name
        cell.leagueCountry.text = league.country_name
        guard let logo = league.league_logo else {
            return UITableViewCell()
        }
        cell.leagueImage.sd_setImage(with: URL(string: logo))
        
        
        return cell
    }
    
    // MARK: Here we detrmine the action when cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let league = leagues[indexPath.row]
        
        let leagueDetailsVC = LeagueDetailsCollectionViewController(nibName: "LeagueDetailsCollectionViewController", bundle: nil)
        
        leagueDetailsVC.leagueId = String(league.league_key)
        leagueDetailsVC.sport = self.sportName!
//        leagueDetailsVC.leagueName = league.league_name
        
        self.navigationController?.pushViewController(leagueDetailsVC, animated: true)
    }
    
    // MARK: Here we update the tableView When data arraives.
    func updateLeagues(leagues: [League]) {
        self.leagues = leagues
        self.leaguesTableView.reloadData()
    }
    
    
    // MARK: Here we update the tableView When data arraives.
    func updateLeaguess(leagues: [League]) {
        print("hello")
    }
    

}
