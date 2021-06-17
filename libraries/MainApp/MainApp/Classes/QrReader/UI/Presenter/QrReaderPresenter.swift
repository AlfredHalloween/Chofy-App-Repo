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
    
    // MARK: RxProperties
    private let permissionsStatusGrantedSubject: PublishSubject = PublishSubject<Bool>()
        
    init(with wireframe: QrReaderWireframeDelegate,
         completion: QRReaderCompletion?) {
        self.wireframe = wireframe
        self.completion = completion
    }
}

extension QrReaderPresenter: QrReaderPresenterDelegate {
    
    var permissionsStatusGranted: Observable<Bool> {
        return permissionsStatusGrantedSubject
    }
    
    func didLoad() {
        permissionsStatusGrantedSubject.onNext(AVCaptureDevice.authorizationStatus(for: .video) == .authorized)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            AVCaptureDevice.requestAccess(for: .video) { [weak self] response in
                guard let self = self else { return }
                if response {
                    
                } else {
                    self.qrNotWorking()
                }
            }
        }
    }
    
    func qrNotWorking() {
        wireframe.showToast(message: "El lector de código de barras no funciona", isWarning: true)
        wireframe.dismissQr(completion: nil)
    }
}
