//
//  HomeViewController.swift
//  SportApp
//
//  Created by Macos on 19/05/2025.
//

import UIKit

class HomeViewController:UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    let sports = [
        Sport(name: "Football", description: "World's most popular sport", image: "football"),
        Sport(name: "Basketball", description: "Fast-paced court action", image: "basketball"),
        Sport(name: "Tennis", description: "Intense rallies and serves", image: "tennis"),
        Sport(name: "Cricket", description: "Cricket is a popular bat-and-ball sport", image: "cricket")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Passing delegate and datasource to CollectionView
        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self
        
        //MARK: CustomCellView with Nib File
        let nib = UINib(nibName: "SportViewCell", bundle: nil)
        sportsCollectionView.register(nib, forCellWithReuseIdentifier: "sportCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    //MARK: handle the size of collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 15
        let height: CGFloat = 325

        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"sportCell", for: indexPath) as! SportViewCell
        
        cell.navigateToLeaguesScreen = { self.navigateToLeaguesScreen(sportName:self.sports[indexPath.row].name)
        }
        
        cell.sportName.text = sports[indexPath.row].name
        cell.sportDesc.text = sports[indexPath.row].description
        cell.sportImage.image = UIImage(named: sports[indexPath.row].image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sport = sports[indexPath.row].name
        self.navigateToLeaguesScreen(sportName: sport)
    }
    
    func navigateToLeaguesScreen(sportName: String){
        let leaguesVC = LeaguesViewController(nibName: "LeaguesViewController", bundle: nil)
        
        leaguesVC.sportName = sportName
        
        self.navigationController?.pushViewController(leaguesVC, animated: true)
    }

}
