//
//  LoginContract.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewLoginProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(message: String)
    func navigateToHome(user: User)
    func showLoginSuccess(message: String)
    func clearFields()
    func setEmailValidationError(_ error: String?)
    func setPasswordValidationError(_ error: String?)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterLoginProtocol: AnyObject {
    var view: PresenterToViewLoginProtocol? { get set }
    var interactor: PresenterToInteractorLoginProtocol? { get set }
    var router: PresenterToRouterLoginProtocol? { get set }
    
    func viewDidLoad()
    func validateInput(email: String, password: String) -> Bool
    func loginButtonTapped(email: String, password: String)
    func forgotPasswordTapped()
    func signUpTapped()
    func loginWithAppleTapped()
    func loginWithGoogleTapped()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorLoginProtocol: AnyObject {
    var presenter: InteractorToPresenterLoginProtocol? { get set }
    
    func loginUser(email: String, password: String)
    func loginWithApple()
    func loginWithGoogle()
    func saveUserSession(user: User, token: String)
    func getLastLoggedInEmail() -> String?
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterLoginProtocol: AnyObject {
    func loginSuccess(user: User)
    func loginFailure(error: String)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterLoginProtocol: AnyObject {
    static func createModule() -> LoginViewController
    
    func navigateToHome(from view: PresenterToViewLoginProtocol?, user: User)
    func navigateToSignUp(from view: PresenterToViewLoginProtocol?)
    func navigateToForgotPassword(from view: PresenterToViewLoginProtocol?)
}
