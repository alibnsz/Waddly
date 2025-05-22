//
//  OnBoardPresenter.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//  
//

import Foundation

final class OnBoardPresenter: ViewToPresenterOnBoardProtocol {

    // MARK: Properties
    private let view: PresenterToViewOnBoardProtocol
    private let interactor: PresenterToInteractorOnBoardProtocol
    private let router: PresenterToRouterOnBoardProtocol


    init(interactor: PresenterToInteractorOnBoardProtocol, router: PresenterToRouterOnBoardProtocol, view: PresenterToViewOnBoardProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension OnBoardPresenter: InteractorToPresenterOnBoardProtocol {
    
}
