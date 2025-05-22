//
//  BaseView.swift
//  Waddly
//
//  Created by Mehmet Ali Bunsuz on 21.05.2025.
//

import UIKit

class BaseView<T: UIViewController>: UIView {
    var controller: T

    init(_ controller: T) {
        self.controller = controller
        super.init(frame: .zero)
        //backgroundColor = Theme.defaultTheme.themeColor.backgroundColor
        setupView()
    }

    func setupView() { }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
