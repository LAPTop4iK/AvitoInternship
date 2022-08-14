//
//  EmployeeCoreDataProperties.swift
//  Avito-Tech-iOS
//
//  Created by Nikita Laptyonok on 14.08.2022.
//

import Foundation
import CoreData


extension EmployeeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeEntity> {
        let sort = NSSortDescriptor(key: "name", ascending: true)
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        request.sortDescriptors = [sort]
        return request
    }
    
    
    @nonobjc public class func batchDeleteRequest() -> NSBatchDeleteRequest {
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EmployeeEntity")
        return NSBatchDeleteRequest(fetchRequest: fetchRequest)
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var skills: [String]?

}
