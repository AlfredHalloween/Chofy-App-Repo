//
//  HomeDataSource.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 16/04/21.
//

import Foundation
import IGListKit

// MARK: HomeDataSourceDelegate
protocol HomeDataSourceDelegate: NSObject {
    func didSelectPage(page: HeaderPager)
    func didSelectSection(section: HomeSection)
}

final class HomeDataSource: NSObject {
    
    // MARK: Properties
    var sections: [ListDiffable] = []
    private var delegate: HomeDataSourceDelegate?
    
    init(delegate: HomeDataSourceDelegate) {
        self.delegate = delegate
    }
}

// MARK: ListAdapterDataSource implementation
extension HomeDataSource: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return sections
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is HeaderPagerDiffable:
            return HeaderPagerSectionController(delegate: self)
        case is HomeSectionDiffable:
            return HomeSectionsSectionController(delegate: self)
        default:
            return ListSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

// MARK: HeaderPagerSectionControllerDelegate implementation
extension HomeDataSource: HeaderPagerSectionControllerDelegate {
    
    func didSelectPage(page: HeaderPager) {
        delegate?.didSelectPage(page: page)
    }
}

// MARK: HomeSectionsSectionControllerDelegate implementation
extension HomeDataSource: HomeSectionsSectionControllerDelegate {
    
    func didSelectSection(section: HomeSection) {
        delegate?.didSelectSection(section: section)
    }
}
