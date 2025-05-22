//
//  TeacherHomeViewController.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 22.05.2025.
//  
//

import UIKit

final class TeacherHomeViewController: UIViewController, NavigationView {
    
    // MARK: - Properties
    var presenter: ViewToPresenterTeacherHomeProtocol!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view = TeacherHomeView(self)
        view.backgroundColor = .white
    }
     
}

extension TeacherHomeViewController: PresenterToViewTeacherHomeProtocol{
    // TODO: Implement View Output Methods
}
