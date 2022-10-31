//
//  SearchPresenter.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import Foundation
import RxSwift
import RxCocoa
import IGListKit
import ChofyExtensions
import SVProgressHUD

protocol SearchPresenterDelegate: SearchViewOutput {
    func getSearchTab() -> UIViewController
}

final class SearchPresenter {
    
    // MARK: Properties
    private let disposeBag: DisposeBag = DisposeBag()
    private let wireframe: SearchWireframeDelegate
    private let interactor: SearchInteractor
    private let sectionsSubject: PublishSubject = PublishSubject<[ListDiffable]>()
    private var searchText: String = ""
    
    init(with wireframe: SearchWireframeDelegate, interactor: SearchInteractor) {
        self.wireframe = wireframe
        self.interactor = interactor
    }
}

extension SearchPresenter: SearchPresenterDelegate {
    
    var sectionsDriver: Driver<[ListDiffable]> {
        return sectionsSubject.asDriver(onErrorJustReturn: [])
    }
    
    // MARK: SearchViewOutput methods
    func didLoad() {
        setEmpty()
        setUpdateObservable()
    }
    
    func beginSearchProducts(name: String) {
        searchText = name
        if name.isEmpty {
            setEmpty()
        } else {
            setProducts(text: searchText)
        }
    }
    
    func didSelectProduct(_ product: Product) {
        wireframe.showProductDetail(product: product)
    }
    
    func showQR() {
        wireframe.showQRScreen { [weak self] code in
            guard let self = self else {
                return
            }
            SVProgressHUD.show()
            self.interactor.getProduct(barCode: code)
                .subscribe(on: MainScheduler.instance)
                .subscribe(onSuccess: { [weak self] product in
                    SVProgressHUD.dismiss()
                    guard let self = self else { return }
                    self.wireframe.showProductDetail(product: product)
                }, onFailure: { [weak self] error in
                    SVProgressHUD.dismiss()
                    guard let self = self else { return }
                    if let error = error as? ErrorResponse,
                       error.statusCode == .notFound {
                        self.wireframe.showNewProduct(barCode: code)
                    } else {
                        self.wireframe.showToast(message: error.localizedDescription, isWarning: true)
                    }
                }).disposed(by: self.disposeBag)
        }
    }
    
    func addNewProduct() {
        wireframe.showNewProduct(barCode: nil)
    }
    
    // MARK: SearchPresenterDelegate methods
    func getSearchTab() -> UIViewController {
        wireframe.getSearchTab(presenter: self)
    }
}

private extension SearchPresenter {
    func setEmpty() {
        sectionsSubject.onNext([
            SearchPlaceholderDiffable(idAnimation: "animation", subtitle: "Aquí puedes buscar el producto que quieras")
        ])
    }
    
    func setProducts(text: String) {
        interactor.getProducts(name: text)
            .asObservable()
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] products in
                guard let self = self else { return }
                let productsDiffable = SearchResultsDiffable(products: products.products)
                self.sectionsSubject.onNext([productsDiffable])
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func setUpdateObservable() {
        wireframe.uploadObservable
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.beginSearchProducts(name: self.searchText)
            }).disposed(by: disposeBag)
    }
}
