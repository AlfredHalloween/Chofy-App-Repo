//
//  GenericModalViewController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 18/06/21.
//

import UIKit
import RxSwift
import RxCocoa
import ChofyStyleGuide

protocol GenericModalViewOutput {
    var input: GenericModalInput { get }
    
    func mainBtnAction()
    func secondaryBtnAction()
}

final class GenericModalViewController: UIViewController {
    
    // MARK: Properties
    private let disposeBag: DisposeBag = DisposeBag()
    private let presenter: GenericModalViewOutput
    
    // MARK: Outlets
    @IBOutlet private weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = ChofyColors.card
        }
    }
    @IBOutlet private weak var adviceLabel: UILabel! {
        didSet {
            adviceLabel.numberOfLines = 1
            adviceLabel.font = ChofyFontCatalog.captionOneMedium
            adviceLabel.textColor = ChofyColors.textObscure
        }
    }
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
            titleLabel.font = ChofyFontCatalog.h1Bold
            titleLabel.textColor = ChofyColors.textObscure
        }
    }
    @IBOutlet private weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.numberOfLines = 1
            subtitleLabel.font = ChofyFontCatalog.bodyRegular
            subtitleLabel.textColor = ChofyColors.textObscure
        }
    }
    @IBOutlet private weak var mainBtn: UIButton!
    @IBOutlet private weak var secondaryBtn: UIButton!
    
    init(presenter: GenericModalViewOutput) {
        let identifier: String = String(describing: GenericModalViewController.self)
        self.presenter = presenter
        super.init(nibName: identifier, bundle: MainBundle.bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been found")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension GenericModalViewController {
    
    func setup() {
        setViewBackground(color: UIColor.clear)
        setupRx()
        setupContainerView()
    }
    
    func setupRx() {
        mainBtnSetup()
        secondaryBtnSetup()
    }
    
    func setupContainerView() {
        adviceLabel.isHidden = presenter.input.advice == nil
        titleLabel.isHidden = presenter.input.title == nil
        subtitleLabel.isHidden = presenter.input.subtitle == nil
        adviceLabel.text = presenter.input.advice
        titleLabel.text = presenter.input.title
        subtitleLabel.text = presenter.input.subtitle
    }
    
    func mainBtnSetup() {
        mainBtn.rx.tap
            .throttle(RxTimeInterval.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.presenter.mainBtnAction()
            }).disposed(by: disposeBag)
    }
    
    func secondaryBtnSetup() {
        secondaryBtn.rx.tap
            .throttle(RxTimeInterval.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.presenter.secondaryBtnAction()
            }).disposed(by: disposeBag)
    }
}
