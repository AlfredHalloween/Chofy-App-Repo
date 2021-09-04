//
//  GenericModalPresenter.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 18/06/21.
//

import Foundation

protocol GenericModalPresenterDelegate: GenericModalViewOutput {
    func showGenericModal()
}

final class GenericModalPresenter {
    
    // MARK: Properties
    private let wireframe: GenericModalWireframeDelegate
    private let interactor: GenericModalInteractorDelegate
    private var mainActionCompletion: GenericModuleCompletion?
    private var secondaryActionCompletion: GenericModuleCompletion?
    
    init(wireframe: GenericModalWireframeDelegate,
         interactor: GenericModalInteractorDelegate,
         mainActionCompletion: @escaping GenericModuleCompletion,
         secondaryActionCompletion: @escaping GenericModuleCompletion) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.mainActionCompletion = mainActionCompletion
        self.secondaryActionCompletion = secondaryActionCompletion
    }
}

extension GenericModalPresenter: GenericModalPresenterDelegate {
    
    var input: GenericModalInput {
        return interactor.input
    }
    
    func mainBtnAction() {
        mainActionCompletion?()
        wireframe.dismiss()
    }
    
    func secondaryBtnAction() {
        secondaryActionCompletion?()
        wireframe.dismiss()
    }
    
    func showGenericModal() {
        wireframe.showGenericModal(presenter: self)
    }
}
