//
//  HomeView.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/13.
//

import Foundation
import SwiftUI
import CoreData

private var kDateType = "kDateType"
private var kDate = "kDate"

struct HomeView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var selectedDateType: BillDateType = .BillDateType_Today
    @State private var selectedDate: Date = Date()
    
    @State private var showCalenderPanel: Bool = false
    @State private var showSwitchAlert: Bool = false
    
    @State private var refreshing: Bool = true
        
    var fetchRequest: NSFetchRequest<Bill>
    init() {
        self.fetchRequest = NSFetchRequest<Bill>(entityName:"Bill")
        self.fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Bill.timestamp, ascending: false)]
    }
    
    private var mainCardDataModel: TopMainCardViewModel {
        get {
            return mainCardData()
        }
    }
        
    private var billDataModel: Array<BillCellViewModel> {
        get {
            return refreshing ? searchBillData(type: selectedDateType, date: selectedDate) : Array()
        }
    }
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    List {
                        Section() {
                            TopMainCardView(model: mainCardDataModel)
                        }
                        Section(header: Text(sectionHeader())
                                    .font(.callout)
                                    .padding(-20)
                                    .foregroundColor(Color.black)) {
                            ForEach(billDataModel) { item in
                                BillCellView(model: item, destinationView: AnyView(BillDetailView(refreshing: $refreshing, originModel: item)), delete: deleteBillCell)
                                    .listRowSeparator(.visible, edges: .all)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    NavigationLink(destination: BillDetailView(refreshing: $refreshing, originModel: BillCellViewModel())) {
                        Label("记一笔", systemImage: "pencil")
                    }
                }
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
        
        let billsResult = calculateBill(bills: billDataModel)
        
        return String(format: str, billsResult.expenditure, billsResult.income)
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
        refreshing = false
        deleteOneBill(model: model)
        refreshing = true
    }
    
//    private func modifyBillCell(model: BillCellViewModel) {
//        let screnDelegate: UIWindowSceneDelegate? = {
//                       var uiScreen: UIScene?
//                       UIApplication.shared.connectedScenes.forEach { (screen) in
//                           uiScreen = screen
//                       }
//                       return (uiScreen?.delegate as? UIWindowSceneDelegate)
//                   }()
//
//
//             screnDelegate?.window!?.rootViewController  = UIHostingController(rootView: BillDetailView(refreshing: $refreshing, originModel: model));
//    }
}


