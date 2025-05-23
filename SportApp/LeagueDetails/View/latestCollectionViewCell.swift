//
//  latestCollectionViewCell.swift
//  SportApp
//
//  Created by NadiaFarid on 22/05/2025.
//

import UIKit

class latestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var team2_image: UIImageView!
    
    @IBOutlet weak var time_text: UILabel!
    @IBOutlet weak var team2_name: UILabel!
    @IBOutlet weak var date_text: UILabel!
    @IBOutlet weak var team1_name: UILabel!
    @IBOutlet weak var score_text: UILabel!
    @IBOutlet weak var vs_text: UILabel!
    @IBOutlet weak var team1_image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureLate(with event: Event) {
//        team1_name.text = event.event_stadium ?? "No Stadium"
        date_text.text = event.event_date ?? "No Date"
        time_text.text = event.event_time ?? "No Time"
        team1_name.text = event.event_home_team ?? "Team 1"
        team2_name.text = event.event_away_team  ?? "Team 2"
        score_text.text = event.event_final_result
        
    
        vs_text.text = "VS"
        
        
        if let team1URLString = event.home_team_logo, let team1URL = URL(string: team1URLString) {
                team1_image.sd_setImage(with: team1URL, placeholderImage: UIImage(named: "football"))
            } else {
                team2_image.image = UIImage(named: "football")
            }

            if let team2URLString = event.away_team_logo, let team2URL = URL(string: team2URLString) {
                team2_image.sd_setImage(with: team2URL, placeholderImage: UIImage(named: "football"))
            } else {
                team2_image.image = UIImage(named: "football")
            }

       
    }

}
