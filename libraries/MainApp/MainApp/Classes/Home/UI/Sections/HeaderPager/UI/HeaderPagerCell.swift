//
//  HeaderPagerCell.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 16/04/21.
//

import UIKit

// MARK: HeaderPagerCellDelegate
protocol HeaderPagerCellDelegate: NSObject {
    func didSelectPage(page: HeaderPager)
}

final class HeaderPagerCell: UICollectionViewCell {
    
    // MARK: Properties
    static let identifier: String = String(describing: HeaderPagerCell.self)
    var delegate: HeaderPagerCellDelegate?
    private var pages: [HeaderPager] = []
    
    // MARK: Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    // MARK: Methods
    func setup(pages: [HeaderPager]) {
        self.pages = pages
        setupCollection()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setupCollection()
    }
}

// MARK: UICollectionViewDataSource implementation
extension HeaderPagerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PageCell.identifier,
            for: indexPath) as! PageCell
        let item = pages[indexPath.row]
        cell.setup(image: item.image, label: item.title)
        return cell
    }
}

// MARK: UICollectionViewDelegate implementation
extension HeaderPagerCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = pages[indexPath.row]
        delegate?.didSelectPage(page: item)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

// MARK: UICollectionViewDelegateFlowLayout implementation
extension HeaderPagerCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width
        let cellHeight = collectionView.bounds.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: Private methods
private extension HeaderPagerCell {
    func setupCollection() {
        setupCollectionFlowLayout()
        setupNib()
        setupPageControl()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupCollectionFlowLayout() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
    
    func setupNib() {
        let nib = UINib(nibName: PageCell.identifier, bundle: MainBundle.bundle)
        collectionView.isPagingEnabled = true
        collectionView.register(nib,
                                forCellWithReuseIdentifier: PageCell.identifier)
    }
    
    func setupPageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
    }
}
