//
//  PlayersTableViewCell.swift
//  SportApp
//
//  Created by NadiaFarid on 22/05/2025.
//

import UIKit

class PlayersTableViewCell: UITableViewCell {

    @IBOutlet weak var player_type: UILabel!
    @IBOutlet weak var player_name: UILabel!
    @IBOutlet weak var players_image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
//        players_image.layer.cornerRadius = players_image.frame.height / 2
//        players_image.clipsToBounds = true
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 500, right: 0))
    
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        // Initialization code
    }
    func configure (with player : Players){
        player_name.text = player.player_name
        player_type.text = player.player_type
        if let imgURL = URL(string: player.player_image ?? "")
        {
            players_image.sd_setImage(with : imgURL ,placeholderImage : UIImage(named: "football" ))
            
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
}
