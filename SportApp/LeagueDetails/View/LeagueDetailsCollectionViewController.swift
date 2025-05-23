//
//  LeagueDetailsCollectionViewController.swift
//  SportApp
//
//  Created by NadiaFarid on 16/05/2025.
//

import UIKit
import CoreData

//private let reuseIdentifier = "eventCell"

class LeagueDetailsCollectionViewController: UICollectionViewController,LeagueDetailsViewProtocol{
    var isFavorite: Bool = false

    var sport : String?
    var type : String?
     var leagueCoutry : String?
    var countryKey : Int?
    var leagueImage : String?
    var leagueName : String?
    var remoteService: RemoteService?
    var localDataSource : LocalDataSource?
   // var leagues: [League] = []
    var presenter: LeaguePresenterProtocol!
    var leagueId: String?
    
        var upcomingEvents: [Event] = []
        var latestEvents: [Event] = []
        var teams: [Team] = []
    func showUpcomingEvents(_ events: [Event]) {
        DispatchQueue.main.async {
               self.upcomingEvents = events
               self.collectionView.reloadSections(IndexSet(integer: LeagueSection.upcomingEvents.rawValue))
           }
    }
    
    func showLatestEvents(_ events: [Event]) {
        DispatchQueue.main.async {
                self.latestEvents = events
                self.collectionView.reloadSections(IndexSet(integer: LeagueSection.latestEvents.rawValue))
            }
    }
    
    func showTeams(_ teams: [Team]) {
        DispatchQueue.main.async {
               self.teams = teams
               self.collectionView.reloadSections(IndexSet(integer: LeagueSection.teams.rawValue))
           }
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
                   print("Error:", message)
                   // show alert if needed
               }
    }
    
    
    enum LeagueSection: Int, CaseIterable {
        case upcomingEvents = 0
        case latestEvents = 1
        case teams = 2
    }
//    let leageKey = Int(leagueId ?? 4)
//    print(leageKey)
  //  let favoriteImage = UIImage(named: "outlineFavorite")
         // MARK: - Favorite Button
    
  
  
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       
     
 
        
        
        let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white// background color
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black] // title color

            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [
               .foregroundColor: UIColor.white, // or any color you prefer
               .font: UIFont.boldSystemFont(ofSize: 20) // optional: customize font
           ]
        let nib = UINib(nibName: "UpEventCollectionViewCell", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: "eventCell")
        
        let nib2 = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        
        
        collectionView.register(nib2, forCellWithReuseIdentifier: "teamImageCell")
        
        let nib3 = UINib(nibName: "latestCollectionViewCell", bundle: nil)
        
        
        collectionView.register(nib3, forCellWithReuseIdentifier: "lateEventCell")
        

        let nib4 = UINib(nibName: "NoDataCollectionViewCell", bundle: nil)
        
        
        collectionView.register(nib3, forCellWithReuseIdentifier: "noData")
        

        
        
        let headerNib = UINib(nibName: "HeaderSectionCollectionReusableView", bundle: nil)
        collectionView.register(headerNib,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "headercell")

        
        collectionView.collectionViewLayout = createLeagueDetailsLayout()
    }
    

  
    private func createCompositionalLayout() -> UICollectionViewLayout {
          let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
              guard let sectionType = LeagueSection(rawValue: sectionIndex) else { return nil }
              switch sectionType {
              case .upcomingEvents:
                  return self.createUpcomingEventsSection()
              case .latestEvents:
                  return self.createLateMiddleEventsSection()
              case .teams:
                  return self.createTeamsSection()
              }
          }
          return layout
      }
    
    func createLeagueDetailsLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return self.createUpcomingEventsSection()
            case 1:
                return self.createLateMiddleEventsSection()// Assuming you have data for this
            case 2:
                return self.createTeamsSection() // Assuming you have data for teams
            default:
                return nil
            }
        }
        return layout
        
    }
//
//    @objc func toggleFavorite() {
//            isFavorite.toggle()
////            favoriteButton.image = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
//
//        }
//
    
    func updateFavoriteButton() {
        guard let leagueId = leagueId else { return }
        isFavorite = localDataSource?.isLeagueInFavorites(leagueKey: leagueId) ?? false
        let imageName = isFavorite ? "favorite" : "outlineFavorite"
        let image = UIImage(named: imageName)
        let button = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(toggleFavorite))
        navigationItem.rightBarButtonItem = button
    }
    @objc func toggleFavorite() {
        guard let leagueId = leagueId,
              let leagueKey = Int(leagueId),
              let leagueName = leagueName,
              
              let sport = sport else { return }

        if isFavorite {
            // Remove from favorites
            if let leagues = localDataSource?.getLeagues(),
               let leagueToRemove = leagues.first(where: { $0.leagueKey == leagueKey }) {
                localDataSource?.removeLeague(league: leagueToRemove)
            }
        } else {
            // Add to favorites
            let league = League(league_key: leagueKey, league_name: leagueName, country_key: countryKey, country_name: leagueCoutry, league_surface: "", league_year: "", league_logo: "", country_logo: leagueImage)
            let imageData = Data() // Replace with actual image data if available
            localDataSource?.saveLeague(league: league, sportName: sport, image: imageData)
        }

        isFavorite.toggle()
        updateFavoriteButton()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "LocalLeague", in: context)

     
     localDataSource = LocalDataSource(entity: entity!, context: context)
        
        updateFavoriteButton()
        
       
//        var favoriteButton: UIBarButtonItem {
//            if let leagueId = leagueId {
//                isFavorite = localDataSource!.isLeagueInFavorites(leagueKey: leagueId)
//
//            }
//            if isFavorite == true {
//                let image = UIImage(named:"favorite")
//
//                let button = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(toggleFavorite))
//                return button
//            }else {
//                let image = UIImage(named:"outlineFavorite")
//
//                let button = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(toggleFavorite))
//                return button
//            }
//
//
//
//            }
//
//        navigationItem.rightBarButtonItem = favoriteButton

     
        
        guard let leagueName = self.leagueName ,
              let leagueId = self.leagueId,
              let sport = self.sport else {
            return
        }
        self.title = " \(leagueName) Leagues"

        print("league id",leagueId)


        presenter = LeaguePresenter(view: self)
        presenter.getUpcomingEvents(leagueId:leagueId ,sportName: "\(sport)")
        presenter.getLatestEvents(leagueId: leagueId ,sportName: "\(sport)")
        presenter.getTeams(leagueId:leagueId ,sportName: "\(sport)")
        
        
        
  

        
    }
    
    
 
    
    
    func createUpcomingEventsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(320),
                                              heightDimension: .estimated(250))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //           item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(17), top: .fixed(15), trailing: nil, bottom: .fixed(5))
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(100))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        section.boundarySupplementaryItems = [createSectionHeader()]
        // If you want a header
        return section
    }
    
    
    
    
    
    func createLateMiddleEventsSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(320),
                                              heightDimension: .estimated(250))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(100))
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(35), top: .fixed(15), trailing: nil, bottom: .fixed(5))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
        section.boundarySupplementaryItems = [createSectionHeader()]
        return section
    }
    
    // MARK: - Teams Section Layout
    
    func createTeamsSection() -> NSCollectionLayoutSection {
        // Assuming circular images, adjust size as needed
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                              heightDimension: .estimated(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(17), top: .fixed(15), trailing: nil, bottom: .fixed(5))
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(100))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        section.boundarySupplementaryItems = [createSectionHeader()]
        return section
    }
    
    // MARK: - Section Header (Optional)
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        return header
    }
    func UpEventLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(320),
                                              heightDimension: .estimated(250))
        
        let item = NSCollectionLayoutItem (layoutSize: itemSize)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(10), top: .fixed(15), trailing: nil, bottom: .fixed(5))
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            return section
        })
        return layout
    }
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 3
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = LeagueSection(rawValue: section) else { return 0 }
             switch sectionType {
             case .upcomingEvents:
               //  return 5
                 return upcomingEvents.count
                // return upcomingEvents.count
             case .latestEvents:
                 //return 4

                 return latestEvents.count
             case .teams:
                // return 4

                 return teams.count
             }

    }
    
    
    
    
    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let sectionType = LeagueSection(rawValue: indexPath.section) else {
//                  fatalError("Invalid section")
//              }
//
//              switch sectionType {
//              case .upcomingEvents:
//
//                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! UpEventCollectionViewCell
//                  let event = upcomingEvents[indexPath.item]
//                 cell.configureUp(with: event)
//
//
//                  return cell
//
//              case .latestEvents:
//                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! UpEventCollectionViewCell
//                  let event = latestEvents[indexPath.item]
//                cell.configureLate(with: event)
//
//                  return cell
//
//              case .teams:
//                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamImageCell", for: indexPath) as! ImageCollectionViewCell
//                  let team = teams[indexPath.item]
//                  cell.configure(with:team)
//                  cell.onImageTapped = {[weak self] in self?.navigateToTeamDetails(team:team)}
//
//                  return cell
//              }
//          }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let sectionType = LeagueSection(rawValue: indexPath.section) else {
            fatalError("Invalid section")
        }

        switch sectionType {
        case .upcomingEvents:
            if upcomingEvents.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noData", for: indexPath) as! NoDataCollectionViewCell
                cell.configureUp()

//                cell.configure(with: "No Upcoming Events")
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! UpEventCollectionViewCell
                let event = upcomingEvents[indexPath.item]
                cell.configureUp(with: event)
                return cell
            }

        case .latestEvents:
            if latestEvents.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noData", for: indexPath) as! NoDataCollectionViewCell
                cell.configureUp()
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! UpEventCollectionViewCell
                let event = latestEvents[indexPath.item]
                cell.configureLate(with: event)
                return cell
            }

        case .teams:
            if teams.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noData", for: indexPath) as! NoDataCollectionViewCell
//                cell.configure(with: "No Teams Available")
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamImageCell", for: indexPath) as! ImageCollectionViewCell
                let team = teams[indexPath.item]
                cell.configure(with: team)
                cell.onImageTapped = { [weak self] in self?.navigateToTeamDetails(team: team) }
                return cell
            }
        }
    }

    func navigateToTeamDetails(team :Team){
        let detailCV = TeamDetailsTableViewController(nibName: "TeamDetailsTableViewController", bundle: nil)
        detailCV.team = team
        self.navigationController?.pushViewController(detailCV, animated: true)
    }

    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headercell", for: indexPath) as!
            HeaderSectionCollectionReusableView
            switch indexPath.section {
            case 0:
                headerView.title_label.text = "Upcoming Events" // Assuming you have a titleLabel in your header view
            case 1:
                headerView.title_label.text = "LatestEvents"
            case 2:
                headerView.title_label.text = "Teams"
            default:
                headerView.title_label.text = ""
            }
            
            return headerView
            
        }
        
        return UICollectionReusableView()
    }

    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
