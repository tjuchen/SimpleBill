//
//  SearchBillView+Data.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/26.
//

import Foundation

extension SearchBillView {
    func searchBillData() -> Array<BillCellViewModel> {
        var dataList = Array<BillCellViewModel>()
        
        let data1 = BillCellViewModel()
        data1.index = 0
        data1.isExpenditure = true
        data1.expenditureType = .BillExpenditureType_Shop
        data1.remark = "方便面"
        data1.money = 41.8
        data1.timeInterval = 1643185120
        dataList.append(data1)
        
        let data2 = BillCellViewModel()
        data2.index = 1
        data2.isExpenditure = false
        data2.incomeType = .BillIncomeType_Salary
        data2.remark = ""
        data2.money = 15000
        data2.timeInterval = 1643098719
        dataList.append(data2)
        
        let data3 = BillCellViewModel()
        data3.index = 2
        data3.isExpenditure = true
        data3.expenditureType = .BillExpenditureType_House
        data3.remark = "房贷"
        data3.money = 15000
        data3.timeInterval = 1611562719
        dataList.append(data3)
                
        return dataList
    }
}
