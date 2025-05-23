//
//  FavoriteViewCell.swift
//  SportApp
//
//  Created by Macos on 23/05/2025.
//

import UIKit

class FavoriteViewCell: UITableViewCell {
    
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueCountry: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
