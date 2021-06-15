//
//  ProductDetailViewController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 06/05/21.
//

import UIKit
import ChofyStyleGuide
import IGListKit
import RxSwift
import RxCocoa

protocol ProductDetailViewOutput {
    var sectionsDriver: Driver<[ListDiffable]> { get }
    
    func didLoad()
    func dismiss()
    func showEditProduct()
}

final class ProductDetailViewController: UIViewController {
    
    private let disposeBag: DisposeBag = DisposeBag()
    private let presenter: ProductDetailViewOutput
    private var dataSource: ProductDetailDataSource?
    private lazy var adapter: ListAdapter = {
       return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = UIColor.clear
        }
    }
    
    init(presenter: ProductDetailViewOutput) {
        let nibName: String = String(describing: ProductDetailViewController.self)
        self.presenter = presenter
        super.init(nibName: nibName, bundle: MainBundle.bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not beeen found")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.didLoad()
    }
}

private extension ProductDetailViewController {
    
    func setup() {
        setViewBackground(color: ChofyColors.screenBackground)
        setupRx()
        setupCollection()
        setupBackBtn()
        setupEditBtn()
    }
    
    func setupCollection() {
        let dataSource: ProductDetailDataSource = ProductDetailDataSource()
        adapter.collectionView = collectionView
        self.dataSource = dataSource
        adapter.dataSource = dataSource
    }
    
    func setupRx() {
        presenter.sectionsDriver
            .drive(onNext: { [weak self] sections in
                guard let self = self else {
                    return
                }
                self.dataSource?.sections = sections
                self.adapter.performUpdates(animated: true)
            }).disposed(by: disposeBag)
    }
    
    func setupBackBtn() {
        let btn: UIBarButtonItem = UIBarButtonItem(image: ChofyIcons.leftArrow, style: .plain, target: nil, action: nil)
        btn.rx.tap
            .throttle(RxTimeInterval.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.presenter.dismiss()
            }).disposed(by: disposeBag)
        navigationItem.leftBarButtonItem = btn
    }
    
    func setupEditBtn() {
        let btn: UIBarButtonItem = UIBarButtonItem(title: "Editar", style: .plain, target: nil, action: nil)
        btn.rx.tap
            .throttle(RxTimeInterval.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.presenter.showEditProduct()
            }).disposed(by: disposeBag)
        navigationItem.rightBarButtonItem = btn
    }
}
