//
//  HomeView+Data.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/21.
//

import Foundation

extension HomeView {
    func mainCardData() -> TopMainCardViewModel {
        let bills = searchTodayBillData()
        let billsResult = calculateBill(bills: bills)
        
        let data = TopMainCardViewModel()
        data.expenditure = billsResult.expenditure
        data.income = billsResult.income
        data.isHiddenMoney = false
        return data
    }
    
    func searchTodayBillData() -> Array<BillCellViewModel> {
        return searchBillData(type: .BillDateType_Today, date: Date())
    }
     
    func searchBillData(type: BillDateType, date: Date) -> Array<BillCellViewModel> {
        fetchRequest.predicate = getPredicate(type: type, date: date)
        
        var model = Array<BillCellViewModel>()
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

extension HomeView {
    func calculateBill(bills: Array<BillCellViewModel>) -> (expenditure: Double, income: Double) {
        let expenditureData = bills.filter{ $0.isExpenditure }
        let incomeData = bills.filter{ !$0.isExpenditure }
        let expenditure = expenditureData.map({$0.money}).reduce(0, +)
        let income = incomeData.map({$0.money}).reduce(0, +)
        return (expenditure, income)
    }
}

extension HomeView {
    static let calendar = Calendar.current
    
    func getPredicate(type: BillDateType, date: Date) -> NSPredicate {
        switch type {
        case .BillDateType_Today:
            return NSPredicate(format: "timestamp >= %lf", getTodayTimeStampStart(selectedDate: date))
        case .BillDateType_AnotherDay:
            return NSPredicate(format: "timestamp >= %lf AND timestamp < %lf", getSomeDayTimeStampStart(selectedDate: date), getSomeDayTimeStampEnd(selectedDate: date))
        case .BillDateType_SomeMonth:
            return NSPredicate(format: "timestamp >= %lf AND timestamp < %lf", getSomeMonthTimeStampStart(selectedDate: date), getSomeMonthTimeStampEnd(selectedDate: date))
        case .BillDateType_SomeYear:
            return NSPredicate(format: "timestamp >= %lf", getSomeYearTimeStampStart(selectedDate: date))
        }
    }
    
    private func getTodayTimeStampStart(selectedDate: Date) -> TimeInterval {
        let today = getSomeDay0Date(date: selectedDate)
        return today.timeIntervalSince1970
    }
    
    private func getSomeDayTimeStampStart(selectedDate: Date) -> TimeInterval {
        let someday = getSomeDay0Date(date: selectedDate)
        return someday.timeIntervalSince1970
    }
    
    private func getSomeDayTimeStampEnd(selectedDate: Date) -> TimeInterval {
        let someday = getSomeDay0Date(date: selectedDate)
        return someday.timeIntervalSince1970 + 86400
    }
    
    private func getSomeMonthTimeStampStart(selectedDate: Date) -> TimeInterval {
        let somemonth = getSomeMonth0Date(date: selectedDate)
        return somemonth.timeIntervalSince1970
    }
    
    private func getSomeMonthTimeStampEnd(selectedDate: Date) -> TimeInterval {
        let somemonth = getSomeMonth0Date(date: selectedDate)
        let range = HomeView.calendar.range(of: .day, in: .month, for: somemonth)!
        let numDays = range.count
        return somemonth.timeIntervalSince1970 + Double(86400 * numDays)
    }
    
    private func getSomeYearTimeStampStart(selectedDate: Date) -> TimeInterval {
        let someyear = getSomeYear0Date(date: selectedDate)
        return someyear.timeIntervalSince1970
    }
    
    private func getSomeDay0Date(date: Date) -> Date {
        let dateComponents = DateComponents(year: HomeView.calendar.component(.year, from: date), month: HomeView.calendar.component(.month, from: date), day: HomeView.calendar.component(.day, from: date))
        return HomeView.calendar.date(from: dateComponents)!
    }
    
    private func getSomeMonth0Date(date: Date) -> Date {
        let dateComponents = DateComponents(year: HomeView.calendar.component(.year, from: date), month: HomeView.calendar.component(.month, from: date))
        return HomeView.calendar.date(from: dateComponents)!
    }
    
    private func getSomeYear0Date(date: Date) -> Date {
        let dateComponents = DateComponents(year: HomeView.calendar.component(.year, from: date))
        return HomeView.calendar.date(from: dateComponents)!
    }
}
