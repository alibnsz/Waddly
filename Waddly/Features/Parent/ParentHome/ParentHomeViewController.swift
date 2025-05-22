//
//  ParentHomeViewController.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 22.05.2025.
//  
//

import UIKit

final class ParentHomeViewController: UIViewController, NavigationView {
    
    // MARK: - Properties
    var presenter: ViewToPresenterParentHomeProtocol!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view = ParentHomeView(self)
        view.backgroundColor = .white
    }
     
}

extension ParentHomeViewController: PresenterToViewParentHomeProtocol{
    // TODO: Implement View Output Methods
}
