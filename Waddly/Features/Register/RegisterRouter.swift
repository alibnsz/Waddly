//
//  RegisterRouter.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//
//

import Foundation
import UIKit

final class RegisterRouter: PresenterToRouterRegisterProtocol {
    // MARK: - Properties
    private weak var navigation: NavigationView?
    
    // MARK: - Initializer
    init(navigation: NavigationView) {
        self.navigation = navigation
    }
    
    // MARK: - Module Creator
    static func createModule() -> RegisterViewController {
        let viewController = RegisterViewController()
        let interactor = RegisterInteractor()
        let router = RegisterRouter(navigation: viewController)
        
        let presenter: ViewToPresenterRegisterProtocol & InteractorToPresenterRegisterProtocol = RegisterPresenter(
            interactor: interactor, router: router, view: viewController)
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        return viewController
    }
    
    // MARK: - Navigation Methods
    func navigateToLogin() {
        // Gerçek bir uygulamada, bu giriş ekranına gidecekti
        // Şimdilik, mevcut view controller'ı pop edelim
        navigation?.navigate(action: .popViewController(animated: true))
    }
    
    func navigateBack() {
        navigation?.navigate(action: .popViewController(animated: true))
    }
}
