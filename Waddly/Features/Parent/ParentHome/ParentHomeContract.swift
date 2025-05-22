//
//  ParentHomeContract.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 22.05.2025.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewParentHomeProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterParentHomeProtocol {
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorParentHomeProtocol {
    
    var presenter: InteractorToPresenterParentHomeProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterParentHomeProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterParentHomeProtocol {
    
}
