//
//  LoginRouter.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//
//

import Foundation
import UIKit

final class LoginRouter: PresenterToRouterLoginProtocol {
    // MARK: - Properties
    private weak var navigation: NavigationView?
    
    // MARK: - Initializer
    init(navigation: NavigationView) {
        self.navigation = navigation
    }
    
    // MARK: - Module Creator
    static func createModule() -> LoginViewController {
        let viewController = LoginViewController()
        let interactor = LoginInteractor()
        let router = LoginRouter(navigation: viewController)

        let presenter: ViewToPresenterLoginProtocol & InteractorToPresenterLoginProtocol = LoginPresenter(
            interactor: interactor, router: router, view: viewController)

        viewController.presenter = presenter
        interactor.presenter = presenter

        return viewController
    }
    
    // MARK: - Navigation Methods
    func navigateToHome(from view: PresenterToViewLoginProtocol?, user: User) {
        guard let viewController = view as? UIViewController else { return }
        
        // Kullanıcı rolüne göre farklı ekrana yönlendir
        let homeViewController: UIViewController
        
        if let role = user.role {
            switch role {
            case .teacher:
                // Öğretmen ana sayfasına yönlendir
                homeViewController = TeacherHomeRouter.createModule()
                print("Öğretmen dashboard'a yönlendiriliyor")
            case .parent:
                // Veli ana sayfasına yönlendir
                homeViewController = ParentHomeRouter.createModule()
                print("Veli dashboard'a yönlendiriliyor")
            }
        } else {
            // Rolü yoksa veya okunamazsa varsayılan ana sayfaya yönlendir
            homeViewController = HomeRouter.createModule()
            print("Rolü belirlenemediği için varsayılan dashboard'a yönlendiriliyor")
        }
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            
            let navigationController = UINavigationController(rootViewController: homeViewController)
            navigationController.isNavigationBarHidden = true
            
            window.rootViewController = navigationController
            
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
        }
    }
    
    func navigateToSignUp(from view: PresenterToViewLoginProtocol?) {
        guard let viewController = view as? UIViewController else { return }
        
        // Create and navigate to the Register screen
        let registerViewController = RegisterRouter.createModule()
        
        if let navigationView = navigation {
            navigationView.navigate(action: .push(viewController: registerViewController, animated: true))
        } else {
            viewController.navigationController?.pushViewController(registerViewController, animated: true)
        }
    }
    
    func navigateToForgotPassword(from view: PresenterToViewLoginProtocol?) {
        guard let viewController = view as? UIViewController else { return }
        
        // Şifre yenileme sayfasına geçiş yapılacak
        // Örnek:
        // let forgotPasswordViewController = ForgotPasswordRouter.createModule()
        // navigation.navigate(action: .push(viewController: forgotPasswordViewController, animated: true))
        
        // Şu an için sadece bir alert gösterelim
        let alert = UIAlertController(title: "Şifremi Unuttum", message: "Şifre yenileme sayfasına geçilecek", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        viewController.present(alert, animated: true)
    }
}
