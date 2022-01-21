//
//  HomeModel.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/17.
//

import Foundation

class TopMainCardViewCellModel {
    var name: String = ""
    var money: Double = 0.0
    var isHiddenMoney: Bool = false
}

class TopMainCardViewModel {
    var showType: BillDateType = .BillDateType_Today
    var expenditure: Double = 0.0
    var income: Double = 0.0
    var isHiddenMoney: Bool = false
}

class BillCellViewModel {
    var isExpenditure: Bool = true
    var expenditureType: BillExpenditureType = .BillExpenditureType_Other
    var incomeType: BillIncomeType = .BillIncomeType_Other
    var remark: String = ""
    var money: Double = 0.0
    var timeInterval: TimeInterval = Date.init(timeIntervalSinceNow: 0).timeIntervalSince1970
}
