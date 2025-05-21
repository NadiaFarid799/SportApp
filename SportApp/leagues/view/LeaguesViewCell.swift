import UIKit

class LeaguesViewCell: UITableViewCell {
    
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueCountry: UILabel!
    @IBOutlet weak var favIcon: UIButton!
    
    var isFilled = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        leagueImage.layer.cornerRadius = leagueImage.frame.width / 2.7
            leagueImage.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    @IBAction func onToggleFavorite(_ sender: Any) {
        
        isFilled = !isFilled
        
        let imageName = isFilled ? "favorite" : "outlineFavorite"
        
        favIcon.setImage(UIImage(named: imageName), for: .normal)
        
    }
    
    
}
