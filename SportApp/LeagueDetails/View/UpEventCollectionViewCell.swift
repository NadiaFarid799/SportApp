//
//  UpEventCollectionViewCell.swift
//  SportApp
//
//  Created by NadiaFarid on 16/05/2025.
//

import UIKit
import SDWebImage
class UpEventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var time_label: UILabel!
    @IBOutlet weak var date_label: UILabel!
    @IBOutlet weak var score2_label: UILabel!
    @IBOutlet weak var dash_label: UILabel!
    @IBOutlet weak var score1_label: UILabel!
    @IBOutlet weak var vs_label: UILabel!
    @IBOutlet weak var team2_image_view: UIImageView!
    @IBOutlet weak var team1_image_view: UIImageView!
    @IBOutlet weak var event_name_label: UILabel!
    
    @IBOutlet weak var team2_name: UILabel!
    @IBOutlet weak var team1_name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       // configure(with: <#T##Event#>)
        // Initialization code
    }

    

    func configureUp(with event: Event) {
        event_name_label.text = event.event_stadium ?? "No Stadium"
        date_label.text = event.event_date ?? "No Date"
        time_label.text = event.event_time ?? "No Time"
        team1_name.text = event.event_home_team ?? "Team 1"
        team2_name.text = event.event_away_team  ?? "Team 2"
        score1_label.text = event.event_final_result



        vs_label.text = "VS"
        
        if let team1URLString = event.home_team_logo, let team1URL = URL(string: team1URLString) {
                team1_image_view.sd_setImage(with: team1URL, placeholderImage: UIImage(named: "placeholder"))
            } else {
                team2_image_view.image = UIImage(named: "placeholder")
            }

            if let team2URLString = event.away_team_logo, let team2URL = URL(string: team2URLString) {
                team2_image_view.sd_setImage(with: team2URL, placeholderImage: UIImage(named: "placeholder"))
            } else {
                team2_image_view.image = UIImage(named: "placeholder")
            }

       
    


    }
    
    func configureLate(with event: Event) {
        event_name_label.text = event.event_stadium ?? "No Stadium"
        date_label.text = event.event_date ?? "No Date"
        time_label.text = event.event_time ?? "No Time"
        team1_name.text = event.event_home_team ?? "Team 1"
        team2_name.text = event.event_away_team  ?? "Team 2"
        score1_label.text = event.event_final_result
        
    
        vs_label.text = "VS"
        
        
        if let team1URLString = event.home_team_logo, let team1URL = URL(string: team1URLString) {
                team1_image_view.sd_setImage(with: team1URL, placeholderImage: UIImage(named: "placeholder"))
            } else {
                team2_image_view.image = UIImage(named: "placeholder")
            }

            if let team2URLString = event.away_team_logo, let team2URL = URL(string: team2URLString) {
                team2_image_view.sd_setImage(with: team2URL, placeholderImage: UIImage(named: "placeholder"))
            } else {
                team2_image_view.image = UIImage(named: "placeholder")
            }

       
    }
    


}
