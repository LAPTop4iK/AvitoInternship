//
//  UIView+Extensions.swift
//  Avito-Tech-iOS
//
//  Created by Nikita Laptyonok on 14.08.2022.
//

import UIKit

extension UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

extension UIView {
    
    /// Add a subview, constrained to the specified top, left, bottom and right margins.
    ///
    /// - Parameters:
    ///   - view: The subview to add.
    ///   - top: Optional top margin constant.
    ///   - left: Optional left (leading) margin constant.
    ///   - bottom: Optional bottom margin constant.
    ///   - right: Optional right (trailing) margin constant.
    ///
    func addConstrained(subview: UIView,
                        top: CGFloat? = 0,
                        left: CGFloat? = 0,
                        bottom: CGFloat? = 0,
                        right: CGFloat? = 0) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)

        if let top = top {
            subview.topAnchor.constraint(equalTo: topAnchor, constant: top).isActive = true
        }
        if let left = left {
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: left).isActive = true
        }
        if let bottom = bottom {
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottom).isActive = true
        }
        if let right = right {
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: right).isActive = true
        }
    }
    
    /// Attaches all sides of the receiver to its parent view
    func coverWholeSuperview(margin: CGFloat = 0.0) {
        let view = superview
        layoutAttachTop(to: view, margin: margin)
        layoutAttachBottom(to: view, margin: margin)
        layoutAttachLeading(to: view, margin: margin)
        layoutAttachTrailing(to: view, margin: margin)

    }

    /// Attaches the top of the current view to the given view's top if it's a superview of the current view
    /// or to it's bottom if it's not (assuming this is then a sibling view).
    @discardableResult
    func layoutAttachTop(to: UIView? = nil, margin: CGFloat = 0.0) -> NSLayoutConstraint {

        let view: UIView? = to ?? superview
        let isSuperview = view == superview
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal,
                                            toItem: view, attribute: isSuperview ? .top : .bottom, multiplier: 1.0,
                                            constant: margin)
        superview?.addConstraint(constraint)

        return constraint
    }

    /// Attaches the bottom of the current view to the given view
    @discardableResult
    func layoutAttachBottom(to: UIView? = nil, margin: CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {

        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal,
                                            toItem: view, attribute: isSuperview ? .bottom : .top, multiplier: 1.0,
                                            constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)

        return constraint
    }

    /// Attaches the leading edge of the current view to the given view
    @discardableResult
    func layoutAttachLeading(to: UIView? = nil, margin: CGFloat = 0.0) -> NSLayoutConstraint {

        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal,
                                            toItem: view, attribute: isSuperview ? .leading : .trailing, multiplier: 1.0,
                                            constant: margin)
        superview?.addConstraint(constraint)

        return constraint
    }

    /// Attaches the trailing edge of the current view to the given view
    @discardableResult
    func layoutAttachTrailing(to: UIView? = nil, margin: CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {

        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal,
                                            toItem: view, attribute: isSuperview ? .trailing : .leading, multiplier: 1.0,
                                            constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)

        return constraint
    }

    // For anchoring View
    struct AnchoredConstraints {
        var top, leading, bottom, trailing, width, height, centerX, centerY: NSLayoutConstraint?
    }

    @discardableResult
    func constraints(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero,
                centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil,
                centerXOffset: CGFloat = 0, centerYOffset: CGFloat = 0) -> AnchoredConstraints {

        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()

        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }

        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }

        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }

        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }

        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }

        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }

        if let centerX = centerX {
            anchoredConstraints.centerX = centerXAnchor.constraint(equalTo: centerX, constant: centerXOffset)
        }

        if let centerY = centerY {
            anchoredConstraints.centerY = centerYAnchor.constraint(equalTo: centerY, constant: centerYOffset)
        }

        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom,
         anchoredConstraints.trailing, anchoredConstraints.width,
         anchoredConstraints.height, anchoredConstraints.centerX,
         anchoredConstraints.centerY].forEach { $0?.isActive = true }

        return anchoredConstraints
    }
}
