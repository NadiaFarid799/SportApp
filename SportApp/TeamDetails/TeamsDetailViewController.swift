//
//  TeamsDetailViewController.swift
//  SportApp
//
//  Created by NadiaFarid on 21/05/2025.
//

import UIKit

class TeamsDetailViewController: UIViewController {
    @IBOutlet weak var team_image: UIImageView!
    
    @IBOutlet weak var team_name: UILabel!
    
    @IBOutlet weak var player_image: UIImageView!
    
//    playerCollectionView.register(UINib(nibName: "PlayersCollectionViewCell", bundle: nil) , forCellReuseIdentifier: "playerCell")
    
    var team : Team?
    var players : [Players] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        team_name.text = team?.team_name ?? "NoTeam"
        
        if let logo2 = team?.players?[0].player_image ,let url = URL(string:logo2){
            player_image.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        }
        
        if let logo = team?.team_logo ,let url = URL(string:logo){
            team_image.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        }
        
//       collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle:nil),forCellWithReuseIdentifier:"teamImageCell" ))

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
