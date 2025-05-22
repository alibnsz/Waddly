//
//  NavigationViewProtocol.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import UIKit

enum NavigationAction {
    case push(viewController: UIViewController, animated: Bool)
    case present(viewController: UIViewController, animated: Bool)
    case popViewController(animated: Bool)
    case dismiss(animated: Bool)
}

protocol NavigationView: AnyObject {
    func navigate(action: NavigationAction)
}

extension NavigationView where Self: UIViewController {
    func navigate(action: NavigationAction) {
        switch action {
        case .push(let viewController, let animated):
            navigationController?.pushViewController(viewController, animated: animated)
            
        case .present(let viewController, let animated):
            present(viewController, animated: animated, completion: nil)
            
        case .popViewController(let animated):
            navigationController?.popViewController(animated: animated)
            
        case .dismiss(let animated):
            dismiss(animated: animated)
        }
    }
}
