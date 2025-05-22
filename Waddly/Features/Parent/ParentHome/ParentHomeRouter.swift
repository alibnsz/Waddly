//
//  TestVbRouter.swift
//  PodcastApp
//
//  Created by vb10 on 1.02.2024.
//
//

import Foundation
import UIKit

final class  ParentHomeRouter: PresenterToRouterParentHomeProtocol {
    // MARK: Static methods

    static func createModule() -> ParentHomeViewController {
        let viewController = ParentHomeViewController()
        let interactor = ParentHomeInteractor()
        let router = ParentHomeRouter(navigation: viewController)

        let presenter: ViewToPresenterParentHomeProtocol & InteractorToPresenterParentHomeProtocol = ParentHomePresenter(
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
