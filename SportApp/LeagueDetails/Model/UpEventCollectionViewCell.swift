//
//  UpEventCollectionViewCell.swift
//  SportApp
//
//  Created by NadiaFarid on 16/05/2025.
//

import UIKit

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

    
//    func configure(with event: Event) {
//        event_name_label.text = event.event_stadium
//        date_label.text = event.event_date
//        time_label.text = event.event_time
//        team1_name.text = event.event_home_team
//        team2_name.text = event.event_away_team
////        score1_label.text = event.intHomeScore
////        awayScoreLabel.text = event.intAwayScore
//    }
//    func configure(with event: Event) {
//        event_name_label.text = event.event_stadium ?? "No Stadium"
//        date_label.text = event.event_date ?? "No Date"
//        time_label.text = event.event_time ?? "No Time"
//        team1_name.text = event.event_home_team ?? "Team 1"
//        team2_name.text = event.event_away_team ?? "Team 2"
//
//        // Hide score labels if scores are not available
////        score1_label.isHidden = true
////        score2_label.isHidden = true
////        dash_label.isHidden = true
//
//        // Optionally show VS
//        vs_label.text = "VS"
//
//        // TODO: Set team images if available (use Kingfisher or URLSession)
//        team1_image_view.image = UIImage(named: "placeholder") // fallback
//        team2_image_view.image = UIImage(named: "placeholder")
//    }


}
