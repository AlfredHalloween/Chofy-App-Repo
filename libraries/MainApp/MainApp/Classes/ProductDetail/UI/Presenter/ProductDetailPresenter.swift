//
//  ProductDetailPresenter.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 06/05/21.
//

import Foundation
import IGListKit
import RxSwift
import RxCocoa
import SVProgressHUD

protocol ProductDetailPresenterDelegate: ProductDetailViewOutput {
    func showProductDetail()
}

final class ProductDetailPresenter {
    
    // MARK: Properties
    private let disposeBag: DisposeBag = DisposeBag()
    private let wireframe: ProductDetailWireframeDelegate
    private let interactor: ProductDetailInteractorDelegate
    private var needsToUploadData: Bool = false
    
    // MARK: Rx Properties
    private let sectionsSubject: PublishSubject = PublishSubject<[ListDiffable]>()
    private let uploadSubject: PublishSubject<Void>
    
    init(wireframe: ProductDetailWireframeDelegate,
         interactor: ProductDetailInteractorDelegate,
         uploadSubject: PublishSubject<Void>) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.uploadSubject = uploadSubject
    }
}

extension ProductDetailPresenter: ProductDetailPresenterDelegate {
    
    var sectionsDriver: Driver<[ListDiffable]> {
        return sectionsSubject.asDriver(onErrorJustReturn: [])
    }
    
    func showProductDetail() {
        wireframe.showProductDetail(presenter: self)
    }
    
    func didLoad() {
        createProductCells()
        wireframe.productObservable
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.needsToUploadData = true
                self.reloadProductInfo()
            }).disposed(by: disposeBag)
    }
    
    func dismiss() {
        needsToUploadData ? uploadSubject.onNext(()) : ()
        wireframe.dismiss()
    }
    
    func showEditProduct() {
        guard let product = interactor.product else { return }
        wireframe.showEditProduct(formType: .edit(product))
    }
}

private extension ProductDetailPresenter {
    
    func reloadProductInfo() {
        guard let id = interactor.product?.id else {
            return
        }
        SVProgressHUD.show()
        interactor.getProduct(id: id)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] product in
                SVProgressHUD.dismiss()
                guard let self = self else { return }
                self.interactor.updateProduct(product: product)
                self.createProductCells()
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                self.wireframe.showToast(message: error.localizedDescription, isWarning: true)
            }).disposed(by: disposeBag)
    }
    
    func createProductCells() {
        var items: [ListDiffable] = [ListDiffable]()
        items.append(createHeaderCell())
        if let description = interactor.product?.description,
           !description.isEmpty {
            items.append(createDescriptionCell(description: description))
        }
        sectionsSubject.onNext(items)
    }
    
    func createHeaderCell() -> ProductDetailHeaderDiffable {
        return ProductDetailHeaderDiffable(image: interactor.product?.image ?? "",
                                           name: interactor.product?.name ?? "",
                                           price: interactor.product?.price ?? 0.0)
    }
    
    func createDescriptionCell(description: String) -> ProductDetailDescriptionDiffable {
        return ProductDetailDescriptionDiffable(title: "Descripción",
                                                description: description)
    }
}
