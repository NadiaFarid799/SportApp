//
//  ImageCollectionViewCell.swift
//  SportApp
//
//  Created by NadiaFarid on 17/05/2025.
//

import UIKit
import SDWebImage

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
    }
        func configure (with team: Team){
            if let logoURLString = team.team_logo,let logoURL = URL(string: logoURLString){
                teamImageView.sd_setImage(with: logoURL, placeholderImage: UIImage(named: "placeholder"))
            }else{
                teamImageView.image = UIImage(named: "placeholder")
            }
        }
    

//    func configure(with team: Team) {
//        if let logoUrl = team.team_logo, let url = URL(string: logoUrl) {
//            teamImageView.kf.setImage(with: url) // Use Kingfisher or SDWebImage
//        }
//        teamNameLabel.text = team.strTeam
//    }


}


//import UIKit
//import SDWebImage
//
//class ImageCollectionViewCell: UICollectionViewCell {
//
//    @IBOutlet weak var teamImageView: UIImageView!
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        teamImageView.clipsToBounds = true
//        teamImageView.contentMode = .scaleAspectFit
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        teamImageView.layer.cornerRadius = teamImageView.frame.size.width / 2
//    }
//
//    func configure(with team: Team) {
//        if let logoURLString = team.team_logo,
//           let logoURL = URL(string: logoURLString) {
//            teamImageView.sd_setImage(with: logoURL, placeholderImage: UIImage(named: "placeholder"))
//        } else {
//            teamImageView.image = UIImage(named: "placeholder")
//        }
//    }
//}
