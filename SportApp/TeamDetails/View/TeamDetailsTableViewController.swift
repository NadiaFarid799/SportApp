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
        tableView.rowHeight = 300
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        
        
        
        
        
        
        /*
         // Override to support conditional editing of the table view.
         override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
         }
         */
        
        /*
         // Override to support editing the table view.
         override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
         // Delete the row from the data source
         tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
         }
         */
        
        /*
         // Override to support rearranging the table view.
         override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
         
         }
         */
        
        /*
         // Override to support conditional rearranging of the table view.
         override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
         }
         */
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
