//
//  TestVbRouter.swift
//  PodcastApp
//
//  Created by vb10 on 1.02.2024.
//
//

import Foundation
import UIKit

final class  TeacherHomeRouter: PresenterToRouterTeacherHomeProtocol {
    // MARK: Static methods

    static func createModule() -> TeacherHomeViewController {
        let viewController = TeacherHomeViewController()
        let interactor = TeacherHomeInteractor()
        let router = TeacherHomeRouter(navigation: viewController)

        let presenter: ViewToPresenterTeacherHomeProtocol & InteractorToPresenterTeacherHomeProtocol = TeacherHomePresenter(
            interactor: interactor, router: router, view: viewController)

        viewController.presenter = presenter
        interactor.presenter = presenter

        return viewController
    }

    private let navigation: NavigationView

    init(navigation: NavigationView) {
        self.navigation = navigation
    }
}
