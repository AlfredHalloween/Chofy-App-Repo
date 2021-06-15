//
//  LoaderIndicatorViewController.swift
//  ChofyExtensions
//
//  Created by Juan Alfredo García González on 11/06/21.
//

import UIKit
import RxSwift
import RxCocoa

public var appWindow: UIWindow? { return UIApplication.shared.delegate?.window ?? nil }

public var windowRootViewController: UIViewController? { return appWindow?.rootViewController }

public var windowTopViewController: UIViewController? {
    func finder(from viewController: UIViewController?) -> UIViewController? {
        if let tabBarViewController = viewController as? UITabBarController {
            return finder(from: tabBarViewController.selectedViewController)
        } else if let navigationController = viewController as? UINavigationController {
            return finder(from: navigationController.visibleViewController)
        } else if let presenterViewController = viewController?.presentedViewController {
            return finder(from: presenterViewController)
        } else {
            return viewController
        }
    }
    return finder(from: windowRootViewController)
}

open class GlobalLoader {
    public static func start() {
        guard (windowTopViewController as? LoaderIndicatorViewController) == nil else {
            return
        }
        let viewController = LoaderIndicatorViewController()
        let baseController = windowTopViewController
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        baseController?.present(viewController, animated: false)
        viewController.activityIndicator?.startAnimating()
        viewController.activityIndicator?.isHidden = false
    }
    
    public static func stop() {
        guard let viewController = windowTopViewController as? LoaderIndicatorViewController else {
            return
        }
        viewController.dismiss(animated: false)
    }
}

final class LoaderIndicatorViewController: UIViewController {
    
    weak var activityIndicator: UIActivityIndicatorView?
    
    init() {
        let identifier: String = String(describing: LoaderIndicatorViewController.self)
        super.init(nibName: identifier, bundle: ChofyExtensionsBundle.bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
