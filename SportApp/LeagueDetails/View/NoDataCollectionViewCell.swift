//
//  NoDataCollectionViewCell.swift
//  SportApp
//
//  Created by NadiaFarid on 23/05/2025.
//

import UIKit

class NoDataCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var message_text: UILabel!
    @IBOutlet weak var image_eror: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureUp() {
        message_text.text = "No Stadium"
        
        image_eror.image = UIImage(named: "footbal")
        
        
    }
}
