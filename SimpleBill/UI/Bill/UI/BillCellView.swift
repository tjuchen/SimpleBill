//
//  BillCellView.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/26.
//

import Foundation
import SwiftUI

struct BillCellView: View {
    @State private var model: BillCellViewModel = BillCellViewModel()
    @State private var showDeleteAlert: Bool = false
    
    private var tempModel: BillCellViewModel = BillCellViewModel()
    private var modify: (_ model: BillCellViewModel) -> Void = {model in }
    private var delete: (_ model: BillCellViewModel) -> Void = {model in }
    
    init(model: BillCellViewModel, @ViewBuilder modify: @escaping (_ model: BillCellViewModel) -> Void, @ViewBuilder delete: @escaping (_ model: BillCellViewModel) -> Void) {
        self.tempModel = model
        self.modify = modify
        self.delete = delete
    }
    
    var body: some View {
        HStack {
            Image(findIconName())
            VStack (
                alignment: .leading,
                spacing: 5
            ) {
                if (model.remark.count == 0) {
                    Text(findTitle())
                        .foregroundColor(Color.colorWithHexString(hexString: "#4B4B4B"))
                } else {
                    Text(findTitle())
                        .foregroundColor(Color.colorWithHexString(hexString: "#4B4B4B"))
                    Text(model.remark)
                        .font(.footnote)
                        .foregroundColor(Color.colorWithHexString(hexString: "#969696"))
                }
            }
            Spacer()
            VStack (
                alignment: .trailing,
                spacing: 5
            ) {
                Text(formatMoney())
                    .foregroundColor(Color.black)
                Text(formatDate())
                    .font(.footnote)
                    .foregroundColor(Color.colorWithHexString(hexString: "#969696"))
            }
        }
        .onAppear {
            model = tempModel
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(title: Text("是否要删除该条账单记录？"),
                  message: Text("删除后不可恢复，请三思！"),
                  primaryButton: .default(
                    Text("确定"),
                    action: deleteBillCell
                  ),
                  secondaryButton: .default(
                    Text("取消")
                  )
            )
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button {
                showDeleteAlert = true
            } label: {
                Label("Delete", systemImage: "trash")
            }
            .tint(.red)
            Button {
                modify(tempModel)
            } label: {
                Label("Flag", systemImage: "highlighter")
            }
            .tint(.orange)
        }
    }
    
    private func deleteBillCell() {
        delete(tempModel)
    }
}

extension BillCellView {
    private func findIconName() -> String {
        return model.isExpenditure ? findExpenditureIconName() : findIncomeIconName()
    }
    
    private func findExpenditureIconName() -> String {
        let name = "expenditure_"
        switch model.expenditureType {
        case .BillExpenditureType_Shop:
            return name.appending("shop")
        case .BillExpenditureType_Food:
            return name.appending("food")
        case .BillExpenditureType_Entertainment:
            return name.appending("entertainment")
        case .BillExpenditureType_Transportation:
            return name.appending("transportation")
        case .BillExpenditureType_Medical:
            return name.appending("medical")
        case .BillExpenditureType_House:
            return name.appending("house")
        case .BillExpenditureType_Communication:
            return name.appending("communication")
        case .BillExpenditureType_Learning:
            return name.appending("learning")
        case .BillExpenditureType_Other:
            return name.appending("other")
        }
    }
    
    private func findIncomeIconName() -> String {
        let name = "income_"
        switch model.incomeType {
        case .BillIncomeType_Salary:
            return name.appending("salary")
        case .BillIncomeType_Bonus:
            return name.appending("bonus")
        case .BillIncomeType_Investment:
            return name.appending("investment")
        case .BillIncomeType_Windfall:
            return name.appending("windfall")
        case .BillIncomeType_Other:
            return name.appending("other")
        }
    }
}

extension BillCellView {
    private func findTitle() -> String {
        return model.isExpenditure ? findExpenditureTitle() : findIncomeTitle()
    }
    
    private func findExpenditureTitle() -> String {
        switch model.expenditureType {
        case .BillExpenditureType_Shop:
            return "购物"
        case .BillExpenditureType_Food:
            return "餐饮"
        case .BillExpenditureType_Entertainment:
            return "娱乐"
        case .BillExpenditureType_Transportation:
            return "交通"
        case .BillExpenditureType_Medical:
            return "医疗"
        case .BillExpenditureType_House:
            return "住房"
        case .BillExpenditureType_Communication:
            return "通讯"
        case .BillExpenditureType_Learning:
            return "学习"
        case .BillExpenditureType_Other:
            return "其他"
        }
    }
    
    private func findIncomeTitle() -> String {
        switch model.incomeType {
        case .BillIncomeType_Salary:
            return "薪资"
        case .BillIncomeType_Bonus:
            return "奖金"
        case .BillIncomeType_Investment:
            return "投资"
        case .BillIncomeType_Windfall:
            return "横财"
        case .BillIncomeType_Other:
            return "其他"
        }
    }
}

extension BillCellView {
    private func formatMoney() -> String {
        return "¥" + String(format:"%.2f", model.money)
    }
    
    private func formatDate() -> String {
        let date = Date.init(timeIntervalSince1970: model.timeInterval)
        let today = Date()
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents(in: TimeZone.current, from: date)
        let todayComponents = calendar.dateComponents(in: TimeZone.current, from: today)
        
        let formatter = DateFormatter.init()
        
        if (dateComponents.year == todayComponents.year) {
            if (dateComponents.month == todayComponents.month && dateComponents.day == todayComponents.day) {
                formatter.dateFormat = "HH:mm"
                return "今天 " + formatter.string(from: date)
            } else {
                formatter.dateFormat = "MM月dd日"
                return formatter.string(from: date)
            }
        } else {
            formatter.dateFormat = "yyyy年MM月dd日"
            return formatter.string(from: date)
        }
    }
}
