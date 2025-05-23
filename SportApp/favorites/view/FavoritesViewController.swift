//
//  FavoritesViewController.swift
//  SportApp
//
//  Created by Macos on 19/05/2025.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,FavoriteViewContract {
    
    var favorites: [LocalLeague] = []
    var favoritesViewPresenter: FavoritePresenter?

    @IBOutlet weak var favoriteNavBar: UINavigationBar!
    @IBOutlet weak var favoriteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: configure the tableView
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        
        // MARK: Setting up the dependencies for CoreData
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "LocalLeague", in: context)
        
        //MARK: Initialize Presenter
        favoritesViewPresenter = FavoritePresenter(localSource: LocalDataSource(entity: entity!, context: context), favoriteViewContract: self)
        
        //MARK: load the League cell NibFile
        let nib = UINib(nibName: "FavoriteViewCell", bundle: nil)
        self.favoriteTableView.register(nib, forCellReuseIdentifier: "favCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteNavBar.topItem?.title = "Favorite Leagues"
        favoritesViewPresenter?.getLocalLeagues()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as? FavoriteViewCell else {
            print("not detected")
            return FavoriteViewCell()
        }
        
        let favLeague = favorites[indexPath.row]
        
        if let leagueImage = favLeague.leagueImage{
            cell.leagueImage.image = UIImage(data: leagueImage)
        }
        
        cell.leagueName.text = favLeague.leagueName
        cell.leagueCountry.text = favLeague.countryName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let leagueToDelete = favorites[indexPath.row]
            
            // Delete from Core Data using the presenter
            favoritesViewPresenter?.deleteLeague(league: leagueToDelete)
            
            // Remove from array and table view
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoritesViewPresenter?.onSelectCell()
    }
    
    func updateLeagues(leagues: [LocalLeague]) {
        favorites = leagues
        favoriteTableView.reloadData()
    }
    
    func naviagateToLeagues() {
        
        guard let indexPath = favoriteTableView.indexPathForSelectedRow else {
            print("cant accure index path")
            return
        }
        
        let league  = favorites[indexPath.row]
        
        let leagueDetailsVC = LeagueDetailsCollectionViewController(nibName: "LeagueDetailsCollectionViewController", bundle: nil)
        
        leagueDetailsVC.leagueId = String(league.leagueKey)
        leagueDetailsVC.sport = league.sportName
        leagueDetailsVC.leagueName = league.leagueName
        
        self.navigationController?.pushViewController(leagueDetailsVC, animated: true)
    }
    
    func fireConnectionAlert() {
        let alert = UIAlertController(
            title: "No Internet Connection",
            message: "Please check your internet settings and try again.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            // Open the Settings app
            if let url = URL(string: UIApplication.openSettingsURLString),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Present the alert
        self.present(alert, animated: true, completion: nil)
    }

}
