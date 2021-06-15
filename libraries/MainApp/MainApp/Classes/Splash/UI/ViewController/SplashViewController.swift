//
//  SplashViewController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import UIKit
import ChofyStyleGuide

protocol SplashViewOutput {
    func didLoad()
}

final class SplashViewController: UIViewController {
    
    // MARK: Properties
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
        setViewBackground(color: ChofyColors.screenBackground)
        presenter.didLoad()
    }
}
