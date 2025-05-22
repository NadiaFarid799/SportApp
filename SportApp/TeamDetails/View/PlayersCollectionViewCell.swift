//
//  PlayersCollectionViewCell.swift
//  SportApp
//
//  Created by NadiaFarid on 21/05/2025.
//

import UIKit
import SDWebImage
class PlayersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var player_name: UILabel!
    @IBOutlet weak var player_image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        player_image.layer.cornerRadius = player_image.frame.width / 2
        player_image.clipsToBounds = true
        // Initialization code
    }
    
    func configure (with player : Players){
        player_name.text = player.player_name
        if let imgURL = URL(string: player.player_image ?? "")
        {
            player_image.sd_setImage(with : imgURL ,placeholderImage : UIImage(named: "placeholder" ))
            
        }
    }
}
