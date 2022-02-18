//
//  BillConfig.swift
//  SimpleBill
//
//  Created by chenyao on 2022/2/11.
//

import Foundation

class BillConfig {
    static func defaultBillExpenditureTypeConfig() -> Dictionary<String, String> {
        return [
            "expenditure_shop": "购物",
            "expenditure_food": "餐饮",
            "expenditure_entertainment": "娱乐",
            "expenditure_transportation": "交通",
            "expenditure_medical": "医疗",
            "expenditure_house": "住房",
            "expenditure_communication": "通讯",
            "expenditure_learning": "学习",
            "expenditure_other": "其他",
        ]
    }
    
    static func defaultBillIncomeTypeConfig() -> Dictionary<String, String> {
        return [
            "income_salary": "薪资",
            "income_bonus": "奖金",
            "income_investment": "投资",
            "income_windfall": "横财",
            "income_other": "其他",
        ]
    }
}
