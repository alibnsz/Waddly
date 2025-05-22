//
//  RegisterContract.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewRegisterProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showFirstNameError(_ error: String?)
    func showLastNameError(_ error: String?)
    func showEmailError(_ error: String?)
    func showPhoneError(_ error: String?)
    func showPasswordError(_ error: String?)
    func showConfirmPasswordError(_ error: String?)
    func showAlert(title: String, message: String)
    func clearForm()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterRegisterProtocol: AnyObject {
    var view: PresenterToViewRegisterProtocol? { get set }
    var interactor: PresenterToInteractorRegisterProtocol? { get set }
    var router: PresenterToRouterRegisterProtocol? { get set }
    
    func register(
        firstName: String,
        lastName: String,
        email: String,
        phone: String,
        password: String,
        confirmPassword: String,
        role: Int,
        termsAccepted: Bool,
        privacyAccepted: Bool
    )
    func goBack()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorRegisterProtocol: AnyObject {
    var presenter: InteractorToPresenterRegisterProtocol? { get set }
    
    func registerUser(
        firstName: String,
        lastName: String,
        email: String,
        phone: String,
        password: String,
        role: Int
    )
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterRegisterProtocol: AnyObject {
    func registerSuccess()
    func registerFailure(error: Error)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterRegisterProtocol: AnyObject {
    static func createModule() -> RegisterViewController
    
    func navigateToLogin()
    func navigateBack()
}
