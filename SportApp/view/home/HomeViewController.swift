import UIKit

class HomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let sports = [
        Sport(name: "Football", description: "World's most popular sport", image: "football"),
        Sport(name: "Basketball", description: "Fast-paced court action", image: "basketball"),
        Sport(name: "Tennis", description: "Intense rallies and serves", image: "tennis"),
        Sport(name: "Cricket", description: "Cricket is a popular bat-and-ball sport", image: "cricket")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Passing delegate and datasource to CollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //MARK: CustomCellView with Nib File
        let nib = UINib(nibName: "SportViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "sportCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 5
        let height: CGFloat = 325

        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"sportCell", for: indexPath) as! SportViewCell
        
        cell.sportName.text = sports[indexPath.row].name
        cell.sportDescription.text = sports[indexPath.row].description
        cell.sportImage.image = UIImage(named: sports[indexPath.row].image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sport = sports[indexPath.row]
        
        print(sport.image)
    }
    
}
