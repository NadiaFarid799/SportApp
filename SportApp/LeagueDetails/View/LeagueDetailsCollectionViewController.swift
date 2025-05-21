//
//  LeagueDetailsCollectionViewController.swift
//  SportApp
//
//  Created by NadiaFarid on 16/05/2025.
//

import UIKit

//private let reuseIdentifier = "eventCell"

class LeagueDetailsCollectionViewController: UICollectionViewController,LeagueDetailsViewProtocol{
  
    var sport : String?
    var type : String?
    //var  leagueId : String?
    
    var remoteService: RemoteService?

    
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
  
    
    var isFavorite: Bool = false

        // MARK: - Favorite Button
    var favoriteButton: UIBarButtonItem {
            let image = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
            let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(toggleFavorite))
            button.tintColor = .green
            return button
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Leagues"
      
//        guard let leagueId = leagueId else {
//            leagueId = "207"
//            return
//        }
        print("league id",leagueId)


        presenter = LeaguePresenter(view: self)
        presenter.getUpcomingEvents(leagueId:leagueId ?? "4",sportName: "football")
        presenter.getLatestEvents(leagueId: leagueId ?? "4",sportName: "football")
        presenter.getTeams(leagueId:leagueId ??  "4",sportName: "football")
        
        
//        presenter = LeagueDetailsPresenter(view: self)
//
//        presenter.getLeagueDetails(leagueId: "207")
//        if leagueId == nil {
//            leagueId = "49"
//        }
//       // presenter.attachView(view:self)
//              if let id = leagueId {
//                  presenter.getLeagueDetails(leagueId : id)
//              }
//        showUpcomingEvents(upcomingEvents)
//        showLatestEvents(latestEvents)
        
        
        let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white // background color
            appearance.titleTextAttributes = [.foregroundColor: UIColor.green] // title color

            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.tintColor = UIColor.green
        navigationController?.navigationBar.titleTextAttributes = [
               .foregroundColor: UIColor.green, // or any color you prefer
               .font: UIFont.boldSystemFont(ofSize: 20) // optional: customize font
           ]
        let nib = UINib(nibName: "UpEventCollectionViewCell", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: "eventCell")
        
        let nib2 = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        
        
        collectionView.register(nib2, forCellWithReuseIdentifier: "teamImageCell")
        
        
        
        navigationItem.rightBarButtonItem = favoriteButton

        //        let layout = UICollectionViewCompositionalLayout { index , enviroment in
        //
        //            if index == 0 {
        //                return self.createUpcomingEventsSection()
        //            } else {
        //                return self.createLateMiddleEventsSection()
        //            }
        //
        //        }
        //
        //        collectionView.setCollectionViewLayout(layout, animated: true)
        
        
        let headerNib = UINib(nibName: "HeaderSectionCollectionReusableView", bundle: nil)
        collectionView.register(headerNib,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "headercell")

//        collectionView.register(SectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        collectionView.collectionViewLayout = createLeagueDetailsLayout()
    }
    
    @objc func toggleFavorite() {
            isFavorite.toggle()
            favoriteButton.image = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
   /// i will use it when i add favourite logic
//            if isFavorite {
//                print("\(leagueName) added to favorites.")
//                UserDefaults.standard.set(true, forKey: "favorite_league_\(leagueId)")
//            } else {
//                print("\(leagueName) removed from favorites.")
//                UserDefaults.standard.set(false, forKey: "favorite_league_\(leagueId)")
//            }
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
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(35), top: .fixed(15), trailing: nil, bottom: .fixed(5))
        
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
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sectionType = LeagueSection(rawValue: indexPath.section) else {
                  fatalError("Invalid section")
              }

              switch sectionType {
              case .upcomingEvents:
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! UpEventCollectionViewCell
                  let event = upcomingEvents[indexPath.item]
                 cell.configureUp(with: event)


                  return cell

              case .latestEvents:
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! UpEventCollectionViewCell
                  let event = latestEvents[indexPath.item]
                cell.configureLate(with: event)

                  return cell

              case .teams:
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamImageCell", for: indexPath) as! ImageCollectionViewCell
                  let team = teams[indexPath.item]
                  cell.configure(with:team)
                  cell.onImageTapped = {[weak self] in self?.navigateToTeamDetails(team:team)}

                  return cell
              }
          }
    func navigateToTeamDetails(team :Team){
        let detailCV = TeamsDetailViewController(nibName: "TeamsDetailViewController", bundle: nil)
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
                headerView.title_label.text = "Late Middle Events"
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
