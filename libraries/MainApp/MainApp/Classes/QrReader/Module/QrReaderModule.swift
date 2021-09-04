//
//  QrReaderModule.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 20/04/21.
//

import Foundation

typealias QRReaderCompletion = (String) -> ()

final class QrReaderModule {
    
    // MARK: Properties
    private let presenter: QrReaderPresenterDelegate
    
    init(with baseController: UIViewController,
         completion: @escaping QRReaderCompletion) {
        let wireframe: QrReaderWireframe = QrReaderWireframe(with: baseController)
        presenter = QrReaderPresenter(with: wireframe, completion: completion)
    }
    
    func showQrReader() {
        presenter.showQrReader()
    }
}
