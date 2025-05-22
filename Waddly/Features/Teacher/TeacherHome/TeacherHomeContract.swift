//
//  TeacherHomeContract.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 22.05.2025.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewTeacherHomeProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterTeacherHomeProtocol {
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorTeacherHomeProtocol {
    
    var presenter: InteractorToPresenterTeacherHomeProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterTeacherHomeProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterTeacherHomeProtocol {
    
}
