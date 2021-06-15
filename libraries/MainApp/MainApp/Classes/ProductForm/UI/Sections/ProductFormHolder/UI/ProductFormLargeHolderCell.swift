//
//  EditProductLargeHolderCell.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 10/06/21.
//

import UIKit
import RxSwift
import RxCocoa
import ChofyStyleGuide

final class ProductFormLargeHolderCell: UICollectionViewCell {
    
    static let cellIdentifier: String = String(describing: ProductFormLargeHolderCell.self)
    private var disposeBag: DisposeBag = DisposeBag()
    private var identifier: String = ""
    weak var delegate: ProductFormHolderCellDelegate?
    
    @IBOutlet private weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = ChofyFontCatalog.bodyMedium
        }
    }
    @IBOutlet private weak var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.backgroundColor = UIColor.white
            descriptionTextView.textColor = ChofyColors.textfieldColor
            descriptionTextView.font = ChofyFontCatalog.bodyRegular
        }
    }
    
    func setup(identifier: String, title: String, description: String) {
        self.identifier = identifier
        nameLabel.text = title
        descriptionTextView.text = description
        setupTextfield()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

private extension ProductFormLargeHolderCell {
    
    func setupTextfield() {
        descriptionTextView.rx.didEndEditing
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.delegate?.didUpdateText(identifier: self.identifier,
                                             text: self.descriptionTextView.text ?? "")
            }).disposed(by: disposeBag)
    }
}
