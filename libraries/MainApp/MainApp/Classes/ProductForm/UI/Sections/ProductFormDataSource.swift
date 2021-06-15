//
//  EditProductDataSource.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 07/06/21.
//

import Foundation
import IGListKit

protocol ProductFormDataSourceDelegate: AnyObject {
    var form: ProductFormDiffable { get }
    
    func didUpdateText(identifier: String, text: String)
    func showQrCamera()
    func openCompanySelector()
}

final class ProductFormDataSource: NSObject {
    
    private weak var delegate: ProductFormDataSourceDelegate?
    private lazy var editSectionController: ProductFormHolderSectionController = {
       return ProductFormHolderSectionController(delegate: self)
    }()
    
    init(delegate: ProductFormDataSourceDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    func update() {
        guard let form = delegate?.form else { return }
        editSectionController.didUpdate(to: form)
    }
}

extension ProductFormDataSource: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        guard let form = delegate?.form else { return [] }
        return [form]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is ProductFormDiffable:
            return editSectionController
        default:
            return ListSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension ProductFormDataSource: ProductFormHolderSectionControllerDelegate {
    func didUpdateText(identifier: String, text: String) {
        delegate?.didUpdateText(identifier: identifier, text: text)
    }
    
    func showQrCamera() {
        delegate?.showQrCamera()
    }
    
    func openCompanySelector() {
        delegate?.openCompanySelector()
    }
}

