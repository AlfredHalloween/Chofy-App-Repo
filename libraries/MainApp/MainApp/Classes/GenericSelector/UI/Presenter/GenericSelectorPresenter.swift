//
//  GenericSelectorPresenter.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 09/06/21.
//

import Foundation
import RxSwift
import RxCocoa
import IGListKit

protocol GenericSelectorPresenterDelegate: GenericSelectorViewOutput {
    func showGenericSelector()
}

final class GenericSelectorPresenter {
    
    // MARK: Properties
    private let wireframe: GenericSelectorWireframeDelegate
    private let interactor: GenericSelectorInteractorDelegate
    private var completion: GenericSelectorCompletion?
    private var genericSelectorDiffable: GenericSelectorDiffable = GenericSelectorDiffable(items: [])
    
    // MARK: Rx Properties
    private let updateDriverSubject: PublishSubject = PublishSubject<[ListDiffable]>()
    
    init(wireframe: GenericSelectorWireframeDelegate,
         interactor: GenericSelectorInteractorDelegate,
         completion: @escaping GenericSelectorCompletion) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.completion = completion
    }
}

extension GenericSelectorPresenter: GenericSelectorPresenterDelegate {
    var updateDriver: Driver<[ListDiffable]> {
        return updateDriverSubject.asDriver(onErrorJustReturn: [])
    }
    
    func showGenericSelector() {
        wireframe.showGenericSelector(presenter: self)
    }
    
    func dismiss() {
        wireframe.dismiss(completion: nil)
    }
    
    func didLoad() {
        genericSelectorDiffable = GenericSelectorDiffable(items: interactor.items)
        updateDriverSubject.onNext([genericSelectorDiffable])
    }
    
    func didSelectSelectorOption(_ option: GenericSelectorItem) {
        wireframe.dismiss { [weak self] in
            guard let self = self else { return }
            self.completion?(option)
        }
    }
    
    func searchCompany(_ company: String) {
        if company.isEmpty {
            genericSelectorDiffable = GenericSelectorDiffable(items: interactor.items)
        } else {
            let filteredArray = interactor.items.filter {
                $0.nameSelector.lowercased().contains(company.lowercased())
            }
            genericSelectorDiffable = GenericSelectorDiffable(items: filteredArray)
        }
        updateDriverSubject.onNext([genericSelectorDiffable])
    }
}
