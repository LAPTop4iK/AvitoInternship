//
//  UIView+Builder.swift
//  Avito-Tech-iOS
//
//  Created by Nikita Laptyonok on 14.08.2022.
//

import UIKit

protocol Creatable: UIView {
    
    init()
    
}

extension Creatable {
    
    static func create(_ builder: (Self) -> Void) -> Self {
        let view = Self()
        builder(view)
        return view
    }
    
}

extension Creatable where Self == UIStackView {
    
    static func create(arrangedViews: [UIView], _ builder: (Self) -> Void) -> Self {
        let stack = UIStackView(arrangedSubviews: arrangedViews)
        builder(stack)
        return stack
    }
    
}

extension UIView: Creatable {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
    
}
