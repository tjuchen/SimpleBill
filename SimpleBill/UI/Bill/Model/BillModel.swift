//
//  BillModel.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/26.
//

import Foundation

class BillCellViewModel: Identifiable {
    var index: Int = 0
    var billID: String = ""
    var isExpenditure: Bool = true
    var billType: String = "expenditure_other"
    var title: String = ""
    var remark: String = ""
    var money: Double = 0.0
    var timestamp: TimeInterval = Date.init(timeIntervalSinceNow: 0).timeIntervalSince1970
}

extension BillCellViewModel {
    func findTitle() -> String {
        return self.isExpenditure ? findExpenditureTitle() : findIncomeTitle()
    }
    
    private func findExpenditureTitle() -> String {
        return BillConfig.defaultBillExpenditureTypeConfig()[self.billType]!
    }
    
    private func findIncomeTitle() -> String {
        return BillConfig.defaultBillIncomeTypeConfig()[self.billType]!
    }
}

class BillTypeModel: Identifiable {
    var title: String = ""
    var iconName: String = ""
}
