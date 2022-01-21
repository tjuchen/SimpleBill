//
//  HomeView+Data.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/21.
//

import Foundation

extension HomeView {
    func mainCardData() -> TopMainCardViewModel {
        let data = TopMainCardViewModel()
        data.showType = BillDateType.BillDateType_Today
        data.expenditure = 100.0
        data.income = 20.0
        data.isHiddenMoney = false
        return data
    }
     
    func searchBillData() -> Array<BillCellViewModel> {
        var dataList = Array<BillCellViewModel>()
        
        let data1 = BillCellViewModel()
        data1.isExpenditure = true
        data1.expenditureType = .BillExpenditureType_Shop
        data1.remark = "方便面"
        data1.money = 41.8
        data1.timeInterval = Date.init(timeIntervalSinceNow: 0).timeIntervalSince1970
        dataList.append(data1)
        
        let data2 = BillCellViewModel()
        data2.isExpenditure = false
        data2.incomeType = .BillIncomeType_Salary
        data2.remark = ""
        data2.money = 15000
        data2.timeInterval = Date.init(timeIntervalSinceNow: 0).timeIntervalSince1970
        dataList.append(data2)
        
        return dataList
    }
}
