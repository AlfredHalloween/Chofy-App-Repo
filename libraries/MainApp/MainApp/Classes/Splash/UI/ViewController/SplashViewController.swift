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
    
    // MARK: Outlet
    private lazy var appTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = ChofyFontCatalog.h2Bold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(with presenter: SplashViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been found")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewBackground(color: ChofyColors.screenBackground)
        setupConstraints()
        presenter.didLoad()
        appTitleLabel.text = "Chofy App"
    }
    
    private func setupConstraints() {
        view.addSubview(appTitleLabel)
        NSLayoutConstraint.activate([
            appTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
