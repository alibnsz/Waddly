//
//  TeacherHomePresenter.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 22.05.2025.
//  
//

import Foundation

final class TeacherHomePresenter: ViewToPresenterTeacherHomeProtocol {

    // MARK: Properties
    private let view: PresenterToViewTeacherHomeProtocol
    private let interactor: PresenterToInteractorTeacherHomeProtocol
    private let router: PresenterToRouterTeacherHomeProtocol


    init(interactor: PresenterToInteractorTeacherHomeProtocol, router: PresenterToRouterTeacherHomeProtocol, view: PresenterToViewTeacherHomeProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension TeacherHomePresenter: InteractorToPresenterTeacherHomeProtocol {
    
}
