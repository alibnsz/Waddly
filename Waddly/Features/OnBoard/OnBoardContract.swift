//
//  OnBoardContract.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewOnBoardProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterOnBoardProtocol {
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorOnBoardProtocol {
    
    var presenter: InteractorToPresenterOnBoardProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterOnBoardProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterOnBoardProtocol {
    
}
