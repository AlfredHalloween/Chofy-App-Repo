//
//  EditProductSelectorCell.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 09/06/21.
//

import UIKit
import ChofyStyleGuide
import RxSwift
import RxCocoa

protocol ProductFormSelectorCellDelegate: AnyObject {
    func openCompanySelector()
}

final class ProductFormSelectorCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: ProductFormSelectorCell.self)
    
    // MARK: Properties
    private var disposeBag: DisposeBag = DisposeBag()
    weak var delegate: ProductFormSelectorCellDelegate?
    
    // MARK: Outlets
    @IBOutlet private weak var placeholderLabel: UILabel! {
        didSet {
            placeholderLabel.font = ChofyFontCatalog.bodyMedium
        }
    }
    @IBOutlet private weak var nameLabel: UITextField! {
        didSet {
            nameLabel.backgroundColor = UIColor.white
            nameLabel.textColor = ChofyColors.textfieldColor
            nameLabel.returnKeyType = .done
            nameLabel.font = ChofyFontCatalog.bodyRegular
        }
    }
    @IBOutlet private weak var arrowImage: UIImageView! {
        didSet {
            let image: UIImage = ChofyIcons.rightArrow.withRenderingMode(.alwaysTemplate)
            arrowImage.image = image
            arrowImage.tintColor = ChofyColors.card
        }
    }
    @IBOutlet private weak var arrowBtn: UIButton!
    
    func setup(placeholder: String,
               name: String,
               isEditable: Bool) {
        placeholderLabel.text = placeholder
        nameLabel.text = name
        nameLabel.isEnabled = isEditable
        setupBtn()
    }
}

private extension ProductFormSelectorCell {
    
    func setupBtn() {
        arrowBtn.rx.tap
            .throttle(RxTimeInterval.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.delegate?.openCompanySelector()
            }).disposed(by: disposeBag)
    }
}
