//
//  EditProductPresenter.swift
//  Pods
//
//  Created by Juan Alfredo García González on 04/06/21.
//

import Foundation
import RxSwift
import RxCocoa
import SVProgressHUD

protocol ProductFormPresenterDelegate: ProductFormViewOutput {
    func showEditProduct()
}

final class ProductFormPresenter {
    
    // MARK: Properties
    private let disposeBag: DisposeBag = DisposeBag()
    private let wireframe: ProductFormWireframeDelegate
    private let interactor: ProductFormInteractorDelegate
    private var formEditable: ProductEditable?
    private var product: Product?
    private var companyName: String?
    private let productSubject: PublishSubject<Void>
    private let fromNavigation: Bool
    
    // MARK: RxProperties
    private let updateSubject: PublishSubject = PublishSubject<Void>()
    private let titleSubject: PublishSubject = PublishSubject<String>()
    
    private var isNewProduct: Bool = true {
        didSet {
            isNewProduct ? titleSubject.onNext("Guardar nuevo producto")
                : titleSubject.onNext("Editar producto")
        }
    }
    
    init(wireframe: ProductFormWireframeDelegate,
         interactor: ProductFormInteractorDelegate,
         productSubject: PublishSubject<Void>,
         fromNavigation: Bool) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.productSubject = productSubject
        self.fromNavigation = fromNavigation
    }
}

extension ProductFormPresenter: ProductFormPresenterDelegate {
    
    var title: Driver<String> {
        return titleSubject.asDriver(onErrorJustReturn: "")
    }
    
    var updateForm: Driver<Void> {
        return updateSubject.asDriver(onErrorJustReturn: ())
    }
    
    var form: ProductFormDiffable {
        return ProductFormDiffable(data: formEditable, companyName: companyName)
    }
    
    func showEditProduct() {
        wireframe.showProductForm(fromNavigation: fromNavigation, presenter: self)
    }
    
    func didLoad() {
        switch interactor.productFormType {
        case .new(let barCode):
            isNewProduct = true
            setNewForm(barCode: barCode)
        case .edit(let product):
            isNewProduct = false
            self.product = product
            setEditForm(product: product)
        }
    }
    
    func dismiss() {
        if fromNavigation {
            wireframe.dismiss()
        } else {
            wireframe.closeNavigation()
        }
    }
    
    func didUpdateText(identifier: String, text: String) {
        switch identifier {
        case ProductFormFieldType.name.rawValue:
            formEditable?.name = text
        case ProductFormFieldType.barCode.rawValue:
            formEditable?.barCode = text
        case ProductFormFieldType.weight.rawValue:
            formEditable?.weight = text
        case ProductFormFieldType.price.rawValue:
            guard let price = Double(text) else { return }
            formEditable?.price = price
        case ProductFormFieldType.description.rawValue:
            formEditable?.description = text
        default:
            break
        }
        self.updateSubject.onNext(())
    }
    
    func confirmAction() {
        if isNewProduct {
            saveProduct()
        } else {
            editProduct()
        }
    }
    
    func showQrCamera() {
        wireframe.showQRScreen { [weak self] code in
            guard let self = self else { return }
            self.formEditable?.barCode = code
            self.updateSubject.onNext(())
        }
    }
    
    func openCompanySelector() {
        let completion: GenericSelectorCompletion = { company in
            guard let company = company as? CompanyEditable else { return }
            self.formEditable?.company = company.id
            self.companyName = company.name
            self.updateSubject.onNext(())
        }
        SVProgressHUD.show()
        interactor.getCompanies()
            .subscribe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] companies in
                SVProgressHUD.dismiss()
                guard let self = self else { return }
                self.wireframe.showCompanySelector(items: companies,
                                                   completion: completion)
            }, onFailure: { [weak self] error in
                SVProgressHUD.dismiss()
                guard let self = self else { return }
                self.wireframe.showToast(message: error.localizedDescription, isWarning: true)
            }).disposed(by: disposeBag)
    }
}

private extension ProductFormPresenter {
    
    func setNewForm(barCode: String?) {
        self.formEditable = ProductEditable()
        if let barCode = barCode {
            formEditable?.barCode = barCode
        }
        updateSubject.onNext(())
    }
    
    func setEditForm(product: Product) {
        guard let productId = product.id,
              let companyId = product.company?.id else { return }
        SVProgressHUD.show()
        Single.zip(interactor.getProduct(id: productId),
                   interactor.getCompany(id: companyId))
            .subscribe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] product, company in
                SVProgressHUD.dismiss()
                guard let self = self else { return }
                self.formEditable = product
                self.companyName = company.name
                self.updateSubject.onNext(())
            }, onFailure: { [weak self] error in
                SVProgressHUD.dismiss()
                guard let self = self else { return }
                self.wireframe.showToast(message: error.localizedDescription, isWarning: true)
                self.dismiss()
            }).disposed(by: disposeBag)
    }
    
    func saveProduct() {
        guard let formEditable = formEditable else { return }
        SVProgressHUD.show()
        interactor.createProduct(product: formEditable)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                SVProgressHUD.dismiss()
                guard let self = self else { return }
                self.productSubject.onNext(())
                self.dismiss()
            }, onFailure: { [weak self] error in
                SVProgressHUD.dismiss()
                guard let self = self else { return }
                self.wireframe.showToast(message: error.localizedDescription,
                                         isWarning: true)
            }).disposed(by: disposeBag)
    }
    
    func editProduct() {
        guard let formEditable = formEditable,
              let productId = self.product?.id else { return }
        SVProgressHUD.show()
        interactor.editProduct(id: productId,
                               product: formEditable)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                SVProgressHUD.dismiss()
                guard let self = self else { return }
                self.productSubject.onNext(())
                self.dismiss()
                self.wireframe.showToast(message: "Los cambios se guardaron correctamente.", isWarning: false)
            }, onFailure: { [weak self] error in
                SVProgressHUD.dismiss()
                guard let self = self else { return }
                self.wireframe.showToast(message: error.localizedDescription,
                                         isWarning: true)
            }).disposed(by: disposeBag)
    }
}
