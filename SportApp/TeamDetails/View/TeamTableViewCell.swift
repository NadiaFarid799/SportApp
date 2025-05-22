//
//  TeamTableViewCell.swift
//  SportApp
//
//  Created by NadiaFarid on 22/05/2025.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    @IBOutlet weak var team_image: UIImageView!
    
    @IBOutlet weak var coach_type: UILabel!
    @IBOutlet weak var coach_name: UILabel!
    @IBOutlet weak var coach_image: UIImageView!
    @IBOutlet weak var caach_label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        coach_image.layer.cornerRadius = coach_image.frame.height / 2
        coach_image.clipsToBounds = true
        // Initialization code
    }
    
    
    func configure ( with team : Team?){
        
       // coach_name.text = team.player_name
        //coach_type.text = player.player_type
        if let logo = team?.team_logo , let url = URL(string:logo){
            team_image.sd_setImage(with: url)
        }
        if let caach = team?.players?.first(where: {$0.player_type?.lowercased() == "goalkeepers"}){
            coach_name.text = caach.player_name
            coach_type.text = caach.player_type
            if let coachImage = caach.player_image,
               let caachURL =  URL(string:coachImage){
                coach_image.sd_setImage(with: caachURL)
        }
        }
        
        //        if let imgTeamURL = URL(string: team.team_logo ?? "")
        //        {
        //            team_image.sd_setImage(with : imgTeamURL ,placeholderImage : UIImage(named: "placeholder" ))}
        //
        //    }
        //        if let imgURL = URL(string: player.player_image ?? "")
        //        {
        //            coach_image.sd_setImage(with : imgURL ,placeholderImage : UIImage(named: "placeholder" ))}
        //
        //    }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

// Initialization code


