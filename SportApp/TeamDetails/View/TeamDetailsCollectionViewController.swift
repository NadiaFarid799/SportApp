//
//  TeamDetailsCollectionViewController.swift
//  SportApp
//
//  Created by NadiaFarid on 21/05/2025.
//

import UIKit

//private let reuseIdentifier = "Cell"

class TeamDetailsCollectionViewController: UICollectionViewController {
    var team : Team?
    var players : [Players] = []
    
//    enum TeamSection: Int, CaseIterable {
//        typealias RawValue = <#type#>
//
//        case players = 0
//        case team = 1
//        case players = 2
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "PlayersCollectionViewCell", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: "playercell")
        collectionView.collectionViewLayout = createLeagueDetailsLayout()

        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    

    

    
//    private func createCompositionalLayout() -> UICollectionViewLayout {
//          let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
//              guard let sectionType = TeamSection(rawValue: sectionIndex) else { return nil }
//              switch sectionType {
//              case .players:
//                  return self.createPlayerSection()
//              case .team:
//                  return self.createPlayerSection()
//              case .players:
//                  return self.createPlayerSection()
//              }
//          }
//          return layout
//      }
    
    func createLeagueDetailsLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return self.createPlayerSection()
            case 1:
                return self.createPlayerSection()// Assuming you have data for this
            case 2:
                return self.createPlayerSection() // Assuming you have data for teams
            default:
                return nil
            }
        }
        return layout
        
    }
    
    
    func createPlayerSection() -> NSCollectionLayoutSection {
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
        //section.boundarySupplementaryItems = [createSectionHeader()]
        // If you want a header
        return section
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return players.count ?? 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playercell", for: indexPath) as! PlayersCollectionViewCell
        
        let player = players[indexPath.row]
        
        cell.configure(with : player)
    
        // Configure the cell
    
        return cell
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
