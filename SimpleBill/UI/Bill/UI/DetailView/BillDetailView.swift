//
//  BillDetailView.swift
//  SimpleBill
//
//  Created by chenyao on 2022/2/11.
//

import Foundation
import SwiftUI
import CoreData

struct BillDetailView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
    @State private var moneyText: String = ""
    @State private var remarkText: String = ""
    @State private var billTypeModel: BillTypeModel = BillTypeModel()
    @State private var showSwitchAlert: Bool = false
    
    @Binding private var refreshing: Bool
        
    private var placeholderMoneyText: String
    private var placeholderRemarkText: String
    
    var originModel: BillCellViewModel
    
    var fetchRequest: NSFetchRequest<Bill>

    init(refreshing: Binding<Bool>, originModel: BillCellViewModel) {
        _refreshing = refreshing
        self.originModel = originModel
        self.placeholderMoneyText = originModel.money>0.0 ? String(format: "%.2lf", originModel.money) : "金额"
        self.placeholderRemarkText = originModel.remark.elementsEqual("") ? "备注" : originModel.remark
        
        self.fetchRequest = NSFetchRequest<Bill>(entityName:"Bill")
        self.fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Bill.timestamp, ascending: false)]
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                    TextField(placeholderMoneyText, text: $moneyText)
                    TextField(placeholderRemarkText, text: $remarkText)
                }
                Section {
                    NavigationLink(destination: BillTypeSelectView(billTypeModel: $billTypeModel, isExpenditure: originModel.isExpenditure)) {
                        Label(billTypeModel.title, image: billTypeModel.iconName)
                    }
                }
            }
            Button {
                if (originModel.billID.elementsEqual("")) {
                    writeOneBill(billTypeModel: billTypeModel, moneyText: moneyText, remarkText: remarkText)
                } else {
                    modifyOneBill(billTypeModel: billTypeModel, moneyText: moneyText, remarkText: remarkText)
                }
                refreshing = true
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("确定")
            }
        }
        .navigationBarTitle(Text(sectionHeader()+"详情"), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showSwitchAlert = true
                } label: {
                    Label("Switch Bill Type", systemImage: "switch.2")
                }
                .confirmationDialog("", isPresented: $showSwitchAlert) {
                    Button("支出", action: switchExpenditure)
                    Button("收入", action: switchIncome)
                } message: {
                    Text("请设置账单类型")
                }
            }
        }.onAppear {
            billTypeModel.iconName = billTypeModel.iconName.elementsEqual("") ? originModel.billType : billTypeModel.iconName
            billTypeModel.title = billTypeModel.title.elementsEqual("") ? originModel.findTitle() : billTypeModel.title
            refreshing = false
        }
    }
}

extension BillDetailView {
    private func sectionHeader() -> String {
        return originModel.isExpenditure ? "支出" : "收入"
    }
                    
    private func switchExpenditure() {
        if (!originModel.isExpenditure) {
            originModel.isExpenditure = true
            originModel.billType = "expenditure_other"
            billTypeModel.iconName = originModel.billType
            billTypeModel.title = originModel.findTitle()
        }
    }
    
    private func switchIncome() {
        if (originModel.isExpenditure) {
            originModel.isExpenditure = false
            originModel.billType = "income_other"
            billTypeModel.iconName = originModel.billType
            billTypeModel.title = originModel.findTitle()
        }
    }
}


