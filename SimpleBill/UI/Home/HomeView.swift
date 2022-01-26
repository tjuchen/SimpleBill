//
//  HomeView.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/13.
//

import Foundation
import SwiftUI

private var kDateType = "kDateType"
private var kDate = "kDate"

struct HomeView: View {
    @State private var selectedDateType: BillDateType = .BillDateType_Today
    @State private var selectedDate: Date = Date()
    
    @State private var showCalenderPanel: Bool = false
    @State private var showSwitchAlert: Bool = false
    
    private var mainCardDataModel: TopMainCardViewModel {
        get {
            return mainCardData()
        }
    }
    
    private var billDataModel: Array<BillCellViewModel> {
        get {
            return searchBillData()
        }
    }
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    Section() {
                        TopMainCardView(model: mainCardDataModel)
                    }
                    Section(header: Text(sectionHeader())
                                .font(.callout)
                                .padding(-20)
                                .foregroundColor(Color.black)) {
                        ForEach(billDataModel) { item in
                            BillCellView(model: item, modify: modifyBillCell, delete: deleteBillCell)
                                .listRowSeparator(.visible, edges: .all)
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .navigationBarTitle("我的记账本")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showCalenderPanel = true
                        } label: {
                            Label("Select Date", systemImage: "calendar")
                        }
                        .onChange(of: selectedDate) { newValue in
                            selectDate()
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showSwitchAlert = true
                        } label: {
                            Label("Switch Bill Type", systemImage: "switch.2")
                        }
                        .confirmationDialog("", isPresented: $showSwitchAlert) {
                            Button("当日账单", action: switchSomeDay)
                            Button("当月账单", action: switchSomeMonth)
                            Button("当年账单", action: switchSomeYear)
                        } message: {
                            Text("请选择要查看的账单类型")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SearchBillView()) {
                            Label("Search Bill", systemImage: "magnifyingglass")
                        }
                    }
                }
                .foregroundColor(Color.blue)
            }
        }
        .calendarPanel(isPresent: $showCalenderPanel, selectedDate: $selectedDate)
    }
}

extension HomeView {
    private func sectionHeader() -> String {
        var str = ""
        switch selectedDateType {
        case .BillDateType_Today:
            str = "今日支出: ¥%.2f  收入: ¥%.2f"
            break
        case .BillDateType_AnotherDay:
            str = "当日支出: ¥%.2f 收入: ¥%.2f"
            break
        case .BillDateType_SomeMonth:
            str = "当月支出: ¥%.2f  收入: ¥%.2f"
            break
        case .BillDateType_SomeYear:
            str = "当年支出: ¥%.2f  收入: ¥%.2f"
            break
        }
        
        let expenditureData = billDataModel.filter{ $0.isExpenditure }
        let incomeData = billDataModel.filter{ !$0.isExpenditure }
        let expenditure = expenditureData.map({$0.money}).reduce(0, +)
        let income = incomeData.map({$0.money}).reduce(0, +)
        
        return String(format: str, expenditure, income)
    }
}

extension HomeView {
    private func selectDate() {
        showCalenderPanel = false
        if (selectedDateType == .BillDateType_Today || selectedDateType == .BillDateType_AnotherDay) {
            switchSomeDay()
        }
    }
    
    private func switchSomeDay() {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "YYYY-MM-DD"
        let todayStr = formatter.string(from: Date())
        let somedayStr = formatter.string(from: selectedDate)
        if (somedayStr.compare(todayStr).rawValue == 0) {
            selectedDateType = .BillDateType_Today
        } else {
            selectedDateType = .BillDateType_AnotherDay
        }
    }
    
    private func switchSomeMonth() {
        selectedDateType = .BillDateType_SomeMonth
    }
    
    private func switchSomeYear() {
        selectedDateType = .BillDateType_SomeYear
    }
}

extension HomeView {
    private func deleteBillCell(model: BillCellViewModel) {
        
    }
    
    private func modifyBillCell(model: BillCellViewModel) {
        
    }
}

