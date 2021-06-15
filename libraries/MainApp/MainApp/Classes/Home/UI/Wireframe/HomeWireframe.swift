//
//  HomeWireframe.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import Foundation

protocol HomeWireframeDelegate {
    func getHomeTab(presenter: HomePresenterDelegate) -> UIViewController
}

final class HomeWireframe {}

extension HomeWireframe: HomeWireframeDelegate {
    func getHomeTab(presenter: HomePresenterDelegate) -> UIViewController {
        return HomeViewController(with: presenter)
    }
}
