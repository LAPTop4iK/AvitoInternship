//
//  UIStackView+Extensions.swift
//  Avito-Tech-iOS
//
//  Created by Nikita Laptyonok on 14.08.2022.
//

import UIKit

extension UIStackView {
    
    func addArrangedViews(_ views: UIView...) {
        views.forEach { view in
            self.addArrangedSubview(view)
        }
    }
}
