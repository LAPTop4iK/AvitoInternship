//
//  EmployeeTableViewCell.swift
//  Avito-Tech-iOS
//
//  Created by Nikita Laptyonok on 14.08.2022.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    private lazy var stackView = UIStackView.create { stack in
        stack.axis = .vertical
        stack.spacing = 8
        
        stack.addArrangedViews(
            nameLabel,
            phoneLabel,
            skillsLabel
        )
    }
    
    private lazy var nameLabel = UILabel.create { label in
        label.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    private lazy var phoneLabel = UILabel.create { label in
        label.font = UIFont.systemFont(ofSize: 18)
    }
    
    private lazy var skillsLabel = UILabel.create { label in
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = .zero
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureLayout()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            }, completion: { finished in
                UIView.animate(withDuration: 0.2) {
                    self.transform = .identity
                }
            })
        }
    }

    func configure(with employeesList: EmployeeEntity) {
        nameLabel.text = employeesList.name
        phoneLabel.text = "Phone number: " + (employeesList.phoneNumber ?? "")
        skillsLabel.text = "Skills: " + (employeesList.skills?.joined(separator: ", ") ?? "")
    }
    
    private func configureLayout() {
        addSubview(stackView)
        
        stackView.constraints(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        )
    }
}
