//
//  HomePresenter.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//  
//

import Foundation

final class HomePresenter: ViewToPresenterHomeProtocol {

    // MARK: Properties
    private let view: PresenterToViewHomeProtocol
    private let interactor: PresenterToInteractorHomeProtocol
    private let router: PresenterToRouterHomeProtocol


    init(interactor: PresenterToInteractorHomeProtocol, router: PresenterToRouterHomeProtocol, view: PresenterToViewHomeProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    
}
