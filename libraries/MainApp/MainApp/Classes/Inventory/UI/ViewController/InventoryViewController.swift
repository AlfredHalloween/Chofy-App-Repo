//
//  InventoryViewController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 16/04/21.
//

import UIKit
import ChofyStyleGuide

protocol InventoryViewOutput {
    
}

final class InventoryViewController: UIViewController {
    
    private let presenter: InventoryViewOutput
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = .clear
        }
    }
    
    
    init(with presenter: InventoryViewOutput) {
        self.presenter = presenter
        let name: String = String(describing: InventoryViewController.self)
        super.init(nibName: name, bundle: MainBundle.bundle)
        title = "Inventario"
        tabBarItem.image = ChofyIcons.clipboard
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been found")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
