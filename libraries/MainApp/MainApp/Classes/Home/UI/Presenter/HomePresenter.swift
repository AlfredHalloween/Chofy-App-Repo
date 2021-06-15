//
//  HomePresenter.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import Foundation
import RxSwift
import RxCocoa
import IGListKit

// MARK: HomePresenterDelegate
protocol HomePresenterDelegate: HomeViewOutput {
    func getHomeTab() -> UIViewController
}

final class HomePresenter: NSObject {
    
    // MARK: Properties
    private let disposeBag: DisposeBag = DisposeBag()
    private let wireframe: HomeWireframeDelegate
    private let interactor: HomeInteractorDelegate
    private let itemsSubject: PublishSubject = PublishSubject<[ListDiffable]>()
    
    init(with wireframe: HomeWireframeDelegate,
         interactor: HomeInteractorDelegate = HomeInteractor()) {
        self.wireframe = wireframe
        self.interactor = interactor
    }
}

extension HomePresenter: HomePresenterDelegate {
    
    // MARK: HomeViewOutput items
    var itemsDriver: Driver<[ListDiffable]> {
        return itemsSubject.asDriver(onErrorJustReturn: [])
    }
    
    // MARK: HomeViewOutput methods
    func didLoad() {
        Single.zip(interactor.getHomePager(), interactor.getHomeSections())
            .subscribe(onSuccess: { [weak self] (pager, sections) in
                guard let self = self else { return }
                self.itemsSubject.onNext([pager, sections])
            }).disposed(by: disposeBag)
    }
    
    // MARK: HomePresenterDelegate methods
    func getHomeTab() -> UIViewController {
        return wireframe.getHomeTab(presenter: self)
    }
    
    // MARK: HomeDataSourceDelegate methods
    func didSelectPage(page: HeaderPager) {
        print(page.title)
    }
    
    func didSelectSection(section: HomeSection) {
        print(section.name)
    }
}


