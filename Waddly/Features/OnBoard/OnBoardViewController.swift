//
//  OnBoardViewController.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//  
//

import UIKit

final class OnBoardViewController: UIViewController, NavigationView {
    
    // MARK: - Properties
    var presenter: ViewToPresenterOnBoardProtocol!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view = OnBoardView(self)
        view.backgroundColor = .white
    }
     
}

extension OnBoardViewController: PresenterToViewOnBoardProtocol{
    // TODO: Implement View Output Methods
}
