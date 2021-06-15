//
//  QrReaderPresenter.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 20/04/21.
//

import Foundation

protocol QrReaderPresenterDelegate: QrReaderViewOutput {
    
    func showQrReader()
}

final class QrReaderPresenter {
    
    private var completion: QRReaderCompletion?
    private let wireframe: QrReaderWireframeDelegate
        
    init(with wireframe: QrReaderWireframeDelegate,
         completion: QRReaderCompletion?) {
        self.wireframe = wireframe
        self.completion = completion
    }
}

extension QrReaderPresenter: QrReaderPresenterDelegate {
    
    func showQrReader() {
        wireframe.showQrReader(presenter: self)
    }
    
    func dismissQr() {
        wireframe.dismissQr(completion: nil)
    }
    
    func sendCode(_ code: String) {
        wireframe.dismissQr { [weak self] in
            guard let self = self else {
                return
            }
            self.completion?(code)
        }
    }
}
