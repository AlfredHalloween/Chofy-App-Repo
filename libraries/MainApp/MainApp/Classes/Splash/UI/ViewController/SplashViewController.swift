//
//  SplashViewController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import UIKit

protocol SplashViewOutput {
    func didLoad()
}

final class SplashViewController: UIViewController {
    
    private let presenter: SplashViewOutput
    
    init(with presenter: SplashViewOutput) {
        self.presenter = presenter
        let name: String = String(describing: SplashViewController.self)
        super.init(nibName: name, bundle: MainBundle.bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been found")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoad()
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
