//
//  EmployeeListViewController.swift
//  Avito-Tech-iOS
//
//  Created by Nikita Laptyonok on 14.08.2022.
//

import UIKit

class EmployeeListViewController: UIViewController {
    
    private let viewModel: EmployeeListViewModel
    private let dataSource = EmployeeListDataSource()
    
    private lazy var tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    init(viewModel: EmployeeListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Employees"
        configureTableView()
        configureSubviews()
        bind()
    }

}

private extension EmployeeListViewController {
    
    func bind() {
        viewModel.completionEmployeesList = { [weak self] list in
            self?.dataSource.employeesList = list
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.tableView.reloadData()
            }
        }
        
        viewModel.getEmployeesList()
        viewModel.router.viewController = self
    }
    
    func configureTableView() {
        refreshControl.addTarget(self, action: #selector(updateTable), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: EmployeeTableViewCell.reuseIdentifier)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }
    
    func configureSubviews() {
        view.addConstrained(subview: tableView)
    }
    
    @objc
    func updateTable() {
        viewModel.getEmployeesList()
    }
    
}
