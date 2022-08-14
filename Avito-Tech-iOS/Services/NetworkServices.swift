//
//  NetworkServices.swift
//  Avito-Tech-iOS
//
//  Created by Nikita Laptyonok on 14.08.2022.
//

import Foundation

class NetworkService {
    
    typealias EmployeesListCompletion = (Result<Company, Error>) -> ()
    typealias ResultCompletion = (Result<Data, Error>) -> ()
    
    static let shared = NetworkService()
    private init() {}
    
    func getEmployeesList(completion: @escaping EmployeesListCompletion) {
        getRequest(URLString: Constants.employeesUrl) { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(data):
                do {
                    let jsonData = try JSONDecoder().decode(Employees.self, from: data)
                    completion(.success(jsonData.company))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
    
extension NetworkService {
    private func getRequest(URLString: String, completion: @escaping ResultCompletion) {
        guard let url = URL(string: URLString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
