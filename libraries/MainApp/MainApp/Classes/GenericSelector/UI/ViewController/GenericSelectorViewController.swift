//
//  GenericSelectorViewController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 09/06/21.
//

import UIKit
import RxSwift
import RxCocoa
import IGListKit
import ChofyStyleGuide

protocol GenericSelectorViewOutput: GenericSelectorOptionDataSourceDelegate {
    var updateDriver: Driver<[ListDiffable]> { get }
    
    func didLoad()
    func dismiss()
    func searchCompany(_ company: String)
}

final class GenericSelectorViewController: UIViewController {
    
    // MARK: Properties
    private let disposeBag: DisposeBag = DisposeBag()
    private let presenter: GenericSelectorViewOutput
    private var dataSource: GenericSelectorOptionDataSource?
    private lazy var adapter: ListAdapter = {
       return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    // MARK: Outlets
    @IBOutlet private weak var searchTextfield: UITextField! {
        didSet {
            searchTextfield.backgroundColor = UIColor.white
            searchTextfield.attributedPlaceholder = NSAttributedString(
                string: "Buscar",
                attributes: [
                    NSAttributedString.Key.font: ChofyFontCatalog.headlineRegular,
                    NSAttributedString.Key.foregroundColor: ChofyColors.placeholderColor
                ])
            searchTextfield.keyboardType = .default
            searchTextfield.font = ChofyFontCatalog.headlineRegular
            searchTextfield.textColor = ChofyColors.textfieldColor
        }
    }
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = UIColor.clear
        }
    }
    @IBOutlet private weak var closeBtn: UIButton! {
        didSet {
            let image = ChofyIcons.close.withRenderingMode(.alwaysTemplate)
            closeBtn.setImage(image, for: .normal)
            closeBtn.setTitleColor(ChofyColors.text, for: .normal)
            closeBtn.tintColor = ChofyColors.text
        }
    }
    
    init(presenter: GenericSelectorViewOutput) {
        let nibName: String = String(describing: GenericSelectorViewController.self)
        self.presenter = presenter
        super.init(nibName: nibName, bundle: MainBundle.bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(:coder) has not been found")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension GenericSelectorViewController {
    
    func setup() {
        setViewBackground(color: ChofyColors.screenBackground)
        setupBackBtn()
        setupCollection()
        setupRx()
        presenter.didLoad()
    }
    
    func setupCollection() {
        dataSource = GenericSelectorOptionDataSource(delegate: presenter)
        adapter.collectionView = collectionView
        adapter.dataSource = dataSource
    }
    
    func setupRx() {
        presenter.updateDriver
            .drive(onNext: { [weak self] diffable in
                guard let self = self else { return }
                self.dataSource?.updateDataSource(items: diffable)
                self.adapter.performUpdates(animated: true)
            }).disposed(by: disposeBag)
        
        closeBtn.rx.tap
            .throttle(RxTimeInterval.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                self.presenter.dismiss()
            }).disposed(by: disposeBag)
        
        searchTextfield.rx.text
            .throttle(RxTimeInterval.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] text in
                guard let self = self,
                      let text = text else { return }
                self.presenter.searchCompany(text)
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
}
