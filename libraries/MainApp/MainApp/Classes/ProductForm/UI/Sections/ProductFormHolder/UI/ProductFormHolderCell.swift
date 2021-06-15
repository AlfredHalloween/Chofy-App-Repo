//
//  EditProductHolderCell.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 07/06/21.
//

import UIKit
import RxSwift
import RxCocoa
import ChofyStyleGuide

protocol ProductFormHolderCellDelegate: AnyObject {
    func didUpdateText(identifier: String, text: String)
    func showQrCamera()
}

final class ProductFormHolderCell: UICollectionViewCell {
    
    // MARK: Properties
    static let cellIdentifier: String = String(describing: ProductFormHolderCell.self)
    private var identifier: String = ""
    private var disposeBag: DisposeBag = DisposeBag()
    weak var delegate: ProductFormHolderCellDelegate?
    
    // MARK: Outlets
    @IBOutlet private weak var placeholder: UILabel! {
        didSet {
            placeholder.font = ChofyFontCatalog.bodyMedium
        }
    }
    @IBOutlet private weak var barCodeContainer: UIView!
    @IBOutlet private weak var iconBarCode: UIImageView! {
        didSet {
            let image: UIImage = ChofyIcons.camera.withRenderingMode(.alwaysTemplate)
            iconBarCode.image = image
            iconBarCode.tintColor = ChofyColors.text
        }
    }
    @IBOutlet private weak var barCodeBtn: UIButton!
    @IBOutlet private weak var textfield: UITextField! {
        didSet {
            textfield.backgroundColor = UIColor.white
            textfield.textColor = ChofyColors.textfieldColor
            textfield.returnKeyType = .done
            textfield.font = ChofyFontCatalog.bodyRegular
        }
    }
    
    func setup(identifier: String,
               text: String,
               placeholderText: String,
               keyboard: UIKeyboardType,
               showBarCode: Bool = false,
               isEditable: Bool) {
        barCodeContainer.isHidden = !showBarCode
        iconBarCode.alpha = showBarCode ? 1.0 : 0.0
        barCodeBtn.alpha = showBarCode ? 1.0 : 0.0
        self.textfield.isEnabled = isEditable
        self.textfield.delegate = self
        self.textfield.keyboardType = keyboard
        placeholder.text = placeholderText
        self.identifier = identifier
        textfield.text = text
        setupTextfield()
        setupCameraBtn()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        barCodeContainer.isHidden = true
        iconBarCode.alpha = 0.0
        barCodeBtn.alpha = 0.0
        textfield.delegate = self
    }
}

extension ProductFormHolderCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.contentView.endEditing(true)
        return false
    }
}

private extension ProductFormHolderCell {
    func setupTextfield() {
        textfield.rx.controlEvent([.editingDidBegin, .editingDidEnd])
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.delegate?.didUpdateText(identifier: self.identifier,
                                             text: self.textfield.text ?? "")
            }).disposed(by: disposeBag)
    }
    
    func setupCameraBtn() {
        barCodeBtn.rx.tap
            .throttle(RxTimeInterval.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.delegate?.showQrCamera()
            }).disposed(by: disposeBag)
    }
}
