//
//  Const.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/17.
//

import Foundation
import UIKit

let kIOSX: Bool = (UIDevice.version() >= 10)

let kScreenHeight: Double = UIScreen.main.bounds.size.height
let kScreenWidth: Double = UIScreen.main.bounds.size.width

enum BillDateType {
    case BillDateType_Today
    case BillDateType_AnotherDay
    case BillDateType_SomeMonth
    case BillDateType_SomeYear
}

enum BillExpenditureType {
    case BillExpenditureType_Shop
    case BillExpenditureType_Food
    case BillExpenditureType_Entertainment
    case BillExpenditureType_Transportation
    case BillExpenditureType_Medical
    case BillExpenditureType_House
    case BillExpenditureType_Communication
    case BillExpenditureType_Learning
    case BillExpenditureType_Other
}

enum BillIncomeType {
    case BillIncomeType_Salary
    case BillIncomeType_Bonus
    case BillIncomeType_Investment
    case BillIncomeType_Windfall
    case BillIncomeType_Other
}
