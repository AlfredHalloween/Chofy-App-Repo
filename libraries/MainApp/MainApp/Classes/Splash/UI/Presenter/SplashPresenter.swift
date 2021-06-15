//
//  SplashPresenter.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import Foundation
import RxSwift

protocol SplashPresenterDelegate: SplashViewOutput {
    func showSplash()
}

final class SplashPresenter {
    
    // MARK: Properties
    private let disposeBag: DisposeBag = DisposeBag()
    private let wireframe: SplashWireframeDelegate
    
    init(with wireframe: SplashWireframe) {
        self.wireframe = wireframe
    }
}

extension SplashPresenter: SplashPresenterDelegate {
    
    func didLoad() {
        Observable<Int>.timer(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.wireframe.showHomeTab()
            }).disposed(by: disposeBag)
    }
    
    func showSplash() {
        wireframe.showSplash(presenter: self)
    }
}
