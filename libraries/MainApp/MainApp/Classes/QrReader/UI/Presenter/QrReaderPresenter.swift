//
//  QrReaderPresenter.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 20/04/21.
//

import Foundation
import AVFoundation
import RxSwift
import RxCocoa

protocol QrReaderPresenterDelegate: QrReaderViewOutput {    
    func showQrReader()
}

final class QrReaderPresenter {
    
    // MARK: Properties
    private var completion: QRReaderCompletion?
    private let wireframe: QrReaderWireframeDelegate
        
    init(with wireframe: QrReaderWireframeDelegate,
         completion: QRReaderCompletion?) {
        self.wireframe = wireframe
        self.completion = completion
    }
}

extension QrReaderPresenter: QrReaderPresenterDelegate {
    
    func didLoad() {
        requestPermissions()
    }
    
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
    
    func requestPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            requestAccess()
        case .denied, .restricted:
            showPermissionAlert()
        case .authorized:
            showPermissionAlert()
        @unknown default:
            break
        }
        
    }
    
    func requestAccess() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] response in
            guard let self = self else { return }
            if response {
                
            } else {
                self.qrNotWorking()
            }
        }
    }
    
    func showPermissionAlert() {
        let main: GenericModuleCompletion = {
            print("Use main action")
        }
        let secondary: GenericModuleCompletion = {
            print("Use secondary action")
        }
        wireframe.showPermissionsModal(mainAction: main,
                                       secondaryAction: secondary)
    }
    
    func qrNotWorking() {
        wireframe.showToast(message: "El lector de código de barras no funciona", isWarning: true)
        wireframe.dismissQr(completion: nil)
    }
}
