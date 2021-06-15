//
//  HomeViewController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import UIKit
import RxSwift
import RxCocoa
import IGListKit
import ChofyStyleGuide

protocol HomeViewOutput: HomeDataSourceDelegate {
    var itemsDriver: Driver<[ListDiffable]> { get }
    
    func didLoad()
}

final class HomeViewController: UIViewController {
    
    private let disposeBag: DisposeBag = DisposeBag()
    private let presenter: HomeViewOutput
    private var dataSource: HomeDataSource?
    private lazy var adapter: ListAdapter = {
       return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = .clear
        }
    }
    
    init(with presenter: HomeViewOutput) {
        self.presenter = presenter
        let name: String = String(describing: HomeViewController.self)
        super.init(nibName: name, bundle: MainBundle.bundle)
        title = "Inicio"
        tabBarItem.image = ChofyIcons.home
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been found")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension HomeViewController {
    
    func setup() {
        setupCollection()
        setupRx()
        presenter.didLoad()
    }
    
    func setupCollection() {
        dataSource = HomeDataSource(delegate: presenter)
        adapter.collectionView = collectionView
        adapter.dataSource = dataSource
    }
    
    func setupRx() {
        presenter.itemsDriver
            .drive(onNext: { [weak self] items in
                guard let self = self else { return }
                self.dataSource?.sections = items
                self.adapter.performUpdates(animated: true)
            }).disposed(by: disposeBag)
    }
}
