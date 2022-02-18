//
//  SearchBillView+Data.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/26.
//

import Foundation

extension SearchBillView {
    func searchBillData(text: String) -> Array<BillCellViewModel> {
        var model = Array<BillCellViewModel>()
        
        if (text.elementsEqual("")) {
            return model
        }
        
        fetchRequest.predicate = getPredicate(text: text)
        do {
            let fetchedObjects = try viewContext.fetch(fetchRequest)
            for index in 0..<fetchedObjects.count {
                let temp = BillCellViewModel()
                let bill = fetchedObjects[index]
                temp.index = index
                temp.billID = bill.billID ?? ""
                temp.isExpenditure = bill.isExpenditure
                temp.billType = bill.billType ?? "expenditure_other"
                temp.remark = bill.remark ?? ""
                temp.money = bill.money
                temp.timestamp = TimeInterval(bill.timestamp)
                temp.title = bill.title ?? ""
                model.append(temp)
            }
        } catch {
            fatalError("读取错误：\(error)")
        }
        return model
    }
    
    func getPredicate(text: String) -> NSPredicate {
        return NSPredicate(format: "title == %@ OR remark == %@", text, text)
    }
    
    func deleteOneBill(model: BillCellViewModel) {
        fetchRequest.predicate = NSPredicate(format: "billID == %@", model.billID)
        do {
            let fetchedObjects = try viewContext.fetch(fetchRequest)
            for info in fetchedObjects{
                viewContext.delete(info)
            }
            try! viewContext.save()
        } catch {
            fatalError("删除错误：\(error)")
        }
    }
}
