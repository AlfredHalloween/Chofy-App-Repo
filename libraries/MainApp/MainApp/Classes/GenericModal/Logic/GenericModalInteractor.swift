//
//  GenericModalInteractor.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 18/06/21.
//

import Foundation

protocol GenericModalInteractorDelegate {
    var input: GenericModalInput { get }
}

final class GenericModalInteractor {
    
    private let inputModel: GenericModalInput
    
    init(input: GenericModalInput) {
        self.inputModel = input
    }
}

extension GenericModalInteractor: GenericModalInteractorDelegate {
    
    var input: GenericModalInput {
        return inputModel
    }
}
