//
//  ParentHomePresenter.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 22.05.2025.
//  
//

import Foundation

final class ParentHomePresenter: ViewToPresenterParentHomeProtocol {

    // MARK: Properties
    private let view: PresenterToViewParentHomeProtocol
    private let interactor: PresenterToInteractorParentHomeProtocol
    private let router: PresenterToRouterParentHomeProtocol


    init(interactor: PresenterToInteractorParentHomeProtocol, router: PresenterToRouterParentHomeProtocol, view: PresenterToViewParentHomeProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension ParentHomePresenter: InteractorToPresenterParentHomeProtocol {
    
}
