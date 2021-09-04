//
//  GenericModalModule.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 18/06/21.
//

import Foundation

typealias GenericModuleCompletion = () -> ()

protocol GenericModalInput {
    var advice: String? { get }
    var title: String? { get }
    var subtitle: String? { get }
    var mainBtnTitle: String { get }
    var secondaryBtnTitle: String { get }
}

final class GenericModalModule {
    
    private let presenter: GenericModalPresenterDelegate
    
    init(with baseController: UIViewController,
         input: GenericModalInput,
         mainActionCompletion: @escaping GenericModuleCompletion,
         secondaryActionCompletion: @escaping GenericModuleCompletion) {
        let wireframe: GenericModalWireframe = GenericModalWireframe(with: baseController)
        let interactor: GenericModalInteractor = GenericModalInteractor(input: input)
        presenter = GenericModalPresenter(wireframe: wireframe,
                                          interactor: interactor,
                                          mainActionCompletion: mainActionCompletion,
                                          secondaryActionCompletion: secondaryActionCompletion)
    }
    
    func showGenericModal() {
        presenter.showGenericModal()
    }
}
