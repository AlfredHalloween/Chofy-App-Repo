//
//  EditProductViewController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 04/06/21.
//

import UIKit
import ChofyStyleGuide
import RxSwift
import RxCocoa
import IGListKit

protocol ProductFormViewOutput: ProductFormDataSourceDelegate {
    var updateForm: Driver<Void> { get }
    var title: Driver<String> { get }
    
    func didLoad()
    func dismiss()
    func confirmAction()
}

final class ProductFormViewController: UIViewController {
    
    // MARK: Properties
    private let disposeBag: DisposeBag = DisposeBag()
    private let presenter: ProductFormViewOutput
    private var dataSource: ProductFormDataSource?
    private lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    // MARK: Outlets
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = UIColor.clear
        }
    }
    @IBOutlet private weak var confirmBtn: UIButton! {
        didSet {
            confirmBtn.layer.cornerRadius = 12
            confirmBtn.setTitleColor(ChofyColors.textObscure, for: .normal)
            confirmBtn.titleLabel?.font = ChofyFontCatalog.headlineBlack
            confirmBtn.backgroundColor = ChofyColors.card
            confirmBtn.setTitle("Confirmar", for: .normal)
        }
    }
    @IBOutlet private weak var keyboardConstraint: NSLayoutConstraint!
    
    init(presenter: ProductFormViewOutput) {
        let identifier: String = String(describing: ProductFormViewController.self)
        self.presenter = presenter
        super.init(nibName: identifier, bundle: MainBundle.bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been found")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setup()
        presenter.didLoad()
    }
}

private extension ProductFormViewController {
    func setup() {
        setViewBackground(color: ChofyColors.screenBackground)
        setupBackBtn()
        setupRx()
        setupCollection()
    }
    
    func setupBackBtn() {
        let btn: UIBarButtonItem = UIBarButtonItem(image: ChofyIcons.leftArrow, style: .plain, target: nil, action: nil)
        btn.tintColor = ChofyColors.text
        btn.rx.tap
            .throttle(RxTimeInterval.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.presenter.dismiss()
            }).disposed(by: disposeBag)
        navigationItem.leftBarButtonItem = btn
    }
    
    func setupCollection() {
        dataSource = ProductFormDataSource(delegate: presenter)
        adapter.collectionView = collectionView
        adapter.dataSource = dataSource
    }
    
    func setupRx() {
        presenter.updateForm
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.dataSource?.update()
                self.adapter.performUpdates(animated: true)
            }).disposed(by: disposeBag)
        
        confirmBtn.rx.tap
            .throttle(RxTimeInterval.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.presenter.confirmAction()
            }).disposed(by: disposeBag)
        
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .subscribe(onNext: { [weak self] notification in
                guard let self = self,
                      let userInfo = notification.userInfo,
                      let frame = userInfo["UIKeyboardFrameEndUserInfoKey"] as? CGRect else {
                    return
                }
                self.keyboardWillShow(true, height: frame.height + 8)
            }).disposed(by: disposeBag)
        
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.keyboardWillShow(true, height: 16)
            }).disposed(by: disposeBag)
        
        presenter.title
            .drive(onNext: { [weak self] title in
                guard let self = self else { return }
                self.title = title
            }).disposed(by: disposeBag)
    }
    
    func keyboardWillShow(_ show: Bool, height: CGFloat) {
        keyboardConstraint.constant = height
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.8,
                       options: UIView.AnimationOptions(),
                       animations: {
                        self.view.layoutIfNeeded()
                       })
    }
}
