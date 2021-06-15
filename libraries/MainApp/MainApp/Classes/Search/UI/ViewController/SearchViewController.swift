//
//  SearchViewController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import UIKit
import RxSwift
import RxCocoa
import IGListKit
import ChofyStyleGuide

protocol SearchViewOutput: SearchDataSourceDelegate {
    var sectionsDriver: Driver<[ListDiffable]> { get }
    
    func didLoad()
    func beginSearchProducts(name: String)
    func showQR()
    func addNewProduct()
}

final class SearchViewController: UIViewController {
    
    // MARK: Properties
    private let disposeBag: DisposeBag = DisposeBag()
    private let presenter: SearchViewOutput
    private var dataSource: SearchDataSource?
    private lazy var adapter: ListAdapter = {
       return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    // MARK: Outlets
    @IBOutlet private weak var searchBar: UITextField! {
        didSet {
            searchBar.backgroundColor = UIColor.white
            searchBar.attributedPlaceholder = NSAttributedString(
                string: "Buscar",
                attributes: [
                    NSAttributedString.Key.font: ChofyFontCatalog.headlineRegular,
                    NSAttributedString.Key.foregroundColor: ChofyColors.placeholderColor
                ])
            searchBar.keyboardType = .default
            searchBar.font = ChofyFontCatalog.headlineRegular
            searchBar.textColor = ChofyColors.textfieldColor
        }
    }
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = UIColor.clear
        }
    }
    @IBOutlet private weak var openQRBtn: UIButton! {
        didSet {
            openQRBtn.roundedView()
            openQRBtn.setImage(ChofyIcons.qr, for: .normal)
            openQRBtn.setTitleColor(ChofyColors.btnTintColor, for: .normal)
            openQRBtn.backgroundColor = ChofyColors.card
            openQRBtn.tintColor = ChofyColors.textObscure
        }
    }
    @IBOutlet private weak var addNewBtn: UIButton! {
        didSet {
            addNewBtn.roundedView()
            addNewBtn.setImage(ChofyIcons.plus, for: .normal)
            addNewBtn.setTitleColor(ChofyColors.textObscure, for: .normal)
            addNewBtn.backgroundColor = ChofyColors.card
            addNewBtn.tintColor = ChofyColors.textObscure
        }
    }
    
    init(with presenter: SearchViewOutput) {
        self.presenter = presenter
        let name: String = String(describing: SearchViewController.self)
        super.init(nibName: name, bundle: MainBundle.bundle)
        title = "Buscador"
        tabBarItem.image = ChofyIcons.loupe
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been found")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension SearchViewController {
    
    func setup() {
        setViewBackground(color: ChofyColors.screenBackground)
        hideKeyboardWhenTappedAround()
        setupCollection()
        setupRx()
        presenter.didLoad()
    }
    
    func setupCollection() {
        dataSource = SearchDataSource(delegate: presenter)
        adapter.collectionView = collectionView
        adapter.dataSource = dataSource
    }
    
    func setupRx() {
        setupSectionsRx()
        setupTextfieldRx()
        setupQRBtnRx()
    }
    
    func setupSectionsRx() {
        presenter.sectionsDriver
            .drive(onNext: { [weak self] sections in
                guard let self = self else {
                    return
                }
                self.dataSource?.sections = sections
                self.adapter.performUpdates(animated: true)
            }).disposed(by: disposeBag)
    }
    
    func setupTextfieldRx() {
        searchBar.rx.text
            .observe(on: MainScheduler.instance)
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] text in
                guard let self = self else {
                    return
                }
                self.presenter.beginSearchProducts(name: text ?? "")
            }).disposed(by: disposeBag)
    }
    
    func setupQRBtnRx() {
        openQRBtn.rx.tap
            .throttle(RxTimeInterval.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.presenter.showQR()
            }).disposed(by: disposeBag)
        
        addNewBtn.rx.tap
            .throttle(RxTimeInterval.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.presenter.addNewProduct()
            }).disposed(by: disposeBag)
    }
}
