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
    
    private var tempModel: BillCellViewModel
    private var destinationView: AnyView
    private var delete: (_ model: BillCellViewModel) -> Void
    
    init(model: BillCellViewModel, destinationView: AnyView, @ViewBuilder delete: @escaping (_ model: BillCellViewModel) -> Void) {
        self.tempModel = model
        self.destinationView = destinationView
        self.delete = delete
    }
    
    var body: some View {
        NavigationLink(destination: destinationView) {
            HStack {
                Image(model.billType)
                VStack (
                    alignment: .leading,
                    spacing: 5
                ) {
                    if (model.remark.count == 0) {
                        Text(model.findTitle())
                            .foregroundColor(Color.colorWithHexString(hexString: "#4B4B4B"))
                    } else {
                        Text(model.findTitle())
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
//            Button {
////                modify(tempModel)
//            } label: {
//                NavigationLink(destination: SearchBillView()) {
//                    Label("Flag", systemImage: "highlighter")
//                }
                
//            }
        }
    }
    
    private func deleteBillCell() {
        delete(tempModel)
    }
}

extension BillCellView {
    private func formatMoney() -> String {
        return "¥" + String(format:"%.2f", model.money)
    }
    
    private func formatDate() -> String {
        let date = Date.init(timeIntervalSince1970: model.timestamp)
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
