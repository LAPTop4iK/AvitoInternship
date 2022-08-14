//
//  EmployeeListRouter.swift
//  Avito-Tech-iOS
//
//  Created by Nikita Laptyonok on 14.08.2022.
//

import UIKit

class EmployeeListRouter {
    
    weak var viewController: UIViewController?
    
    func showError(_ error: Error, completion: @escaping () -> Void) {
        makeAlertController(title: error.localizedDescription, message: nil, completion: completion)
    }
    
    private func makeAlertController(title: String?, message: String?, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let refreshButton = UIAlertAction(title: "Refresh", style: .default) { _ in
            completion()
        }
        let cancelButton = UIAlertAction(title: "Close", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(refreshButton)
        alert.addAction(cancelButton)
        viewController?.present(alert, animated: true, completion: nil)
    }
}
