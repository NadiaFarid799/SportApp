//
//  TeamDetailsTableViewController.swift
//  SportApp
//
//  Created by NadiaFarid on 22/05/2025.
//

import UIKit

class TeamDetailsTableViewController: UITableViewController {
    
    
    var team : Team?
    var players : [Players] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = team?.team_name ?? "Teams"
        let nib = UINib(nibName: "PlayersTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "playercell")
        
        let nib2 = UINib(nibName: "TeamTableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "teamcell")
        
        tableView.rowHeight = UITableView.automaticDimension
       
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {
            return 1
        }else {
            return team?.players?.filter { $0.player_type?.lowercased() != "coach" }.count ?? 0
        }
        //  return team?.players?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        }else {
            return 100
        }
    }
    


    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacer  = UIView()
        spacer.backgroundColor = .clear
        return spacer
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2{
            return "Players"
            
    }
    return nil
        
    }
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "teamcell", for: indexPath) as! TeamTableViewCell
            cell.configure(with: team )
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "playercell", for: indexPath) as! PlayersTableViewCell
            let players = team?.players?.filter{
                $0.player_type?.lowercased() != "coach"
            }    ?? []
            
            cell.configure(with: players [indexPath.row])
            
            return cell
            
        }
        
        
        
        
        
     
        
    }
}
