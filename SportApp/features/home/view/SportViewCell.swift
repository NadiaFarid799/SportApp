
import UIKit

class SportViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var sportName: UILabel!
    @IBOutlet weak var sportDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Rounded corners
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
            
        // Shadow (elevation)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
            
        layer.masksToBounds = false  //Allow shadow to show outside bounds
        
    }

}
