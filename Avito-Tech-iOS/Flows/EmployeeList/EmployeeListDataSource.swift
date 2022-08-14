//
//  EmployeeListDataSource.swift
//  Avito-Tech-iOS
//
//  Created by Nikita Laptyonok on 14.08.2022.
//

import UIKit

class EmployeeListDataSource: NSObject {
    
    var sizingCell = EmployeeTableViewCell()
    var employeesList = [EmployeeEntity]()
    
}

extension EmployeeListDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employeesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: EmployeeTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? EmployeeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: employeesList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
}

extension EmployeeListDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = employeesList[indexPath.row]
        
        sizingCell.frame = CGRect(
            origin: .zero,
            size: CGSize(width: tableView.bounds.width, height: 1000)
        )
        
        sizingCell.configure(with: item)
        sizingCell.setNeedsLayout()
        sizingCell.layoutIfNeeded()

        let size = sizingCell.systemLayoutSizeFitting(
            CGSize(width: tableView.bounds.width, height: .greatestFiniteMagnitude),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        )

        return size.height
    }
    
}

