//
//  ImageCollectionViewCell.swift
//  SportApp
//
//  Created by NadiaFarid on 17/05/2025.
//

import UIKit
//import Kingfisher


class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var teamImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        teamImageView.clipsToBounds = true
        teamImageView.contentMode = .scaleAspectFit
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        teamImageView.layer.cornerRadius = teamImageView.frame.size.width / 2
       
        func configure (with image : UIImage?){
            teamImageView.image = image
        }
    }
//    func configure(with team: Team) {
//        if let logoUrl = team.team_logo, let url = URL(string: logoUrl) {
//            teamImageView.kf.setImage(with: url) // Use Kingfisher or SDWebImage
//        }
//        teamNameLabel.text = team.strTeam
//    }


}
