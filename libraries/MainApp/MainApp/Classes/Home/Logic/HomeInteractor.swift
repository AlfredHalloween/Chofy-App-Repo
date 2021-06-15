//
//  HomeInteractor.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 17/04/21.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: HomeInteractorDelegate protocol
protocol HomeInteractorDelegate {
    func getHomePager() -> Single<HeaderPagerDiffable>
    func getHomeSections() -> Single<HomeSectionDiffable>
}

final class HomeInteractor {}

// MARK: HomeInteractorDelegate implementation
extension HomeInteractor: HomeInteractorDelegate {

    // MARK: HomeInteractorDelegate methods
    func getHomePager() -> Single<HeaderPagerDiffable> {
        let page1 = HeaderPager(title: "Título 1",
                                image: "https://s23527.pcdn.co/wp-content/uploads/2017/08/Shot-Caller-New-Banner-poster.jpg.optimal.jpg")
        let page2 = HeaderPager(title: "Título 2",
                                image: "https://images2.alphacoders.com/114/1140506.jpg")
        let page3 = HeaderPager(title: "Título 3",
                                image: "https://images5.alphacoders.com/114/1141372.jpg")
        let pages = [page1, page2, page3]
        
        let pagerHeader = HeaderPagerDiffable(identifier: "header",
                                              pages: pages)
        return .just(pagerHeader)
    }
    
    func getHomeSections() -> Single<HomeSectionDiffable> {
        let sections = [
            HomeSection(image: "https://icons.iconarchive.com/icons/graphicloads/food-drink/128/drink-icon.png",
                        name: "Bebidas"),
            HomeSection(image: "https://icons.iconarchive.com/icons/webalys/kameleon.pics/128/Food-Dome-icon.png",
                        name: "Comida"),
            HomeSection(image: "https://icons.iconarchive.com/icons/graphicloads/food-drink/128/drink-4-icon.png",
                        name: "Alcohol"),
            HomeSection(image: "https://icons.iconarchive.com/icons/webalys/kameleon.pics/128/Candy-icon.png",
                        name: "Dulceria"),
            HomeSection(image: "https://icons.iconarchive.com/icons/graphicloads/100-flat-2/128/phone-icon.png",
                        name: "Otros servicios")
        ]
        let sectionsDiffable = HomeSectionDiffable(title: "Titulo de la sección para ver la muestra del demo",
                                                   subtitle: "Subtitulo de la sección",
                                                   sections: sections)
        return .just(sectionsDiffable)
    }
}
