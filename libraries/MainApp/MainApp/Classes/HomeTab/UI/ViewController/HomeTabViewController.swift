//
//  HomeTabViewController.swift
//  MainApp
//
//  Created by Juan Alfredo García González on 15/04/21.
//

import UIKit
import ChofyStyleGuide

protocol HomeTabViewOutput {
    var viewControllers: [UIViewController] { get }
}

final class HomeTabViewController: UITabBarController {
    
    private let presenter: HomeTabViewOutput
    
    init(with presenter: HomeTabViewOutput) {
        self.presenter = presenter
        let name: String = String(describing: HomeTabViewController.self)
        super.init(nibName: name, bundle: MainBundle.bundle)
        tabBar.barTintColor = ChofyColors.screenBackground
        tabBar.tintColor = ChofyColors.btnTintColor
        self.viewControllers = presenter.viewControllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been found")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension HomeTabViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          animationControllerForTransitionFrom fromVC: UIViewController,
                          to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let controllers = tabBarController.viewControllers,
              let fromIndex = controllers.firstIndex(of: fromVC),
              let toIndex = controllers.firstIndex(of: toVC),
              fromIndex != toIndex else {
            return nil
        }
        let scrollRight: Bool = toIndex > fromIndex
        return TabBarAnimatedTransitioning(isScrollRight: scrollRight,
                                           fromVc: fromVC,
                                           toVc: toVC)
    }
}

final class TabBarAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let isScrollRight: Bool
    private let fromVc: UIViewController
    private let toVc: UIViewController
    
    init(isScrollRight: Bool, fromVc: UIViewController, toVc: UIViewController) {
        self.isScrollRight = isScrollRight
        self.fromVc = fromVc
        self.toVc = toVc
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let origin = fromVc.view,
              let destination = toVc.view else { return }
        origin.superview?.addSubview(destination)
        let screenWidth: CGFloat = UIScreen.main.bounds.size.width
        let offset: CGFloat = isScrollRight ? screenWidth : -screenWidth
        destination.center = CGPoint(x: origin.center.x + offset, y: destination.center.y)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0.0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        origin.center = CGPoint(x: origin.center.x - offset, y: origin.center.y)
                        destination.center = CGPoint(x: destination.center.x - offset, y: destination.center.y)
                       }, completion: {
                        origin.removeFromSuperview()
                        transitionContext.completeTransition($0)
                       })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
}
