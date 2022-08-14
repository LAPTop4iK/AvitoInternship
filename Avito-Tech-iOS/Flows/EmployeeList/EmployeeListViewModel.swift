//
//  EmployeeListViewModel.swift
//  Avito-Tech-iOS
//
//  Created by Nikita Laptyonok on 14.08.2022.
//

import Foundation

class EmployeeListViewModel {
    
    typealias EmployeesList = (([EmployeeEntity]) -> Void)
    
    let router = EmployeeListRouter()
    
    var completionEmployeesList: EmployeesList?
    var items: [EmployeeEntity]?
    
    private let context = AppDelegate.container.viewContext
    
}

extension EmployeeListViewModel {
    
    func getEmployeesList() {
        guard let lastDate = AppData.latestRequestTime else {
            sendRequest()
            return
        }
        
        let isOldRefresh = ((Date().timeIntervalSince1970 - lastDate.timeIntervalSince1970) / (60 * 60)) > 1
        
        isOldRefresh ? sendRequest() : fetchPeople()
    }
    
}

private extension EmployeeListViewModel {
    
    func fetchPeople() {
        do {
            items = try context.fetch(EmployeeEntity.fetchRequest())
        } catch {
            print("DEBUGPRINT: Fetching people error")
        }
        completionEmployeesList?(items ?? [])
    }
    
    func sendRequest() {
        NetworkService.shared.getEmployeesList { [weak self] result in
            switch result {
            case let .success(company):
                self?.cleanCoreData()
                self?.savePersons(employeesList: company.employees)
                AppData.latestRequestTime = Date()
                self?.fetchPeople()
            case let .failure( error):
                DispatchQueue.main.async {
                    self?.router.showError(error, completion: {
                        self?.getEmployeesList()
                    })
                }
            }
        }
    }
    
    func cleanCoreData() {
        do {
            try context.executeAndMergeChanges(using: EmployeeEntity.batchDeleteRequest())
        } catch {
            print("DEBUGPRINT: Fetching people error")
        }
    }
    
    func savePersons(employeesList: [Employee]) {
        
        employeesList.forEach {
            let newPerson = EmployeeEntity(context: context)
            newPerson.name = $0.name
            newPerson.phoneNumber = $0.phoneNumber
            newPerson.skills = $0.skills
        }
        
        do {
            try context.save()
        } catch {
            print ("DEBUGPRINT: Data saving error")
        }
    }
}



