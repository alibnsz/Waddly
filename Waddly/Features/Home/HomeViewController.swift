//
//  HomeViewController.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//  
//

import UIKit

final class HomeViewController: UIViewController, NavigationView {
    
    // MARK: - Properties
    var presenter: ViewToPresenterHomeProtocol!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view = HomeView(self)
        view.backgroundColor = .white
    }
     
}

extension HomeViewController: PresenterToViewHomeProtocol{
    // TODO: Implement View Output Methods
}
