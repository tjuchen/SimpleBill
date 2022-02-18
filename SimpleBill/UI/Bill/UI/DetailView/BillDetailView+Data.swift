//
//  BillDetailView+Data.swift
//  SimpleBill
//
//  Created by chenyao on 2022/2/18.
//

import Foundation

extension BillDetailView {
    func writeOneBill(billTypeModel: BillTypeModel, moneyText: String, remarkText: String) {
        let stamp = Date().timeIntervalSince1970
        let bill = Bill(context: viewContext)
        bill.billID = String(format: "%.0f", stamp)
        bill.isExpenditure = originModel.isExpenditure
        bill.billType = billTypeModel.iconName
        bill.title = billTypeModel.title
        bill.money = Double(moneyText) ?? 0.0
        bill.remark = remarkText
        bill.timestamp = stamp
        
        try? viewContext.save()
    }
    
    func modifyOneBill(billTypeModel: BillTypeModel, moneyText: String, remarkText: String) {
        fetchRequest.predicate = NSPredicate(format: "billID == %@", originModel.billID)
        do {
            let fetchedObjects = try viewContext.fetch(fetchRequest)
            for bill in fetchedObjects{
                if (!moneyText.elementsEqual("")) {
                    bill.money = Double(moneyText) ?? 0.0
                }
                if (!remarkText.elementsEqual("")) {
                    bill.remark = remarkText
                }
                bill.billType = billTypeModel.iconName
                bill.title = billTypeModel.title
            }
            try! viewContext.save()
        } catch {
            fatalError("删除错误：\(error)")
        }
    }
}
