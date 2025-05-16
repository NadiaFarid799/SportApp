//
//  testViewController.swift
//  SportApp
//
//  Created by NadiaFarid on 15/05/2025.
//

import UIKit

class testViewController: UIViewController {

    @IBOutlet weak var test_btn: UIButton!
    @IBOutlet weak var test_label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func goToNext(_ sender: Any) {
        let myVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    
}
