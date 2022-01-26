//
//  BillModel.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/26.
//

import Foundation

class BillCellViewModel: Identifiable {
    var index: Int = 0
    var isExpenditure: Bool = true
    var expenditureType: BillExpenditureType = .BillExpenditureType_Other
    var incomeType: BillIncomeType = .BillIncomeType_Other
    var remark: String = ""
    var money: Double = 0.0
    var timeInterval: TimeInterval = Date.init(timeIntervalSinceNow: 0).timeIntervalSince1970
}
