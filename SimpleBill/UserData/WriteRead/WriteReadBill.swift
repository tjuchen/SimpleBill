//
//  WriteReadBill.swift
//  SimpleBill
//
//  Created by chenyao on 2022/2/14.
//

import Foundation
import CoreData

class WriteReadBill: NSManagedObject {
    static let context: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    
    func fetchAllBills() -> NSFetchRequestResult? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bill")
        if let bills = (try? WriteReadBill.context.fetch(request).first as? Bill) {
            return bills
        }
        return nil
    }
}
