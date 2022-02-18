//
//  BillTypeSelectView.swift
//  SimpleBill
//
//  Created by chenyao on 2022/2/11.
//

import Foundation
import SwiftUI

struct BillTypeSelectView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var billTypeModel: BillTypeModel
    let isExpenditure: Bool
    
    private let expenditureConfig = BillConfig.defaultBillExpenditureTypeConfig()
    private let incomeConfig = BillConfig.defaultBillIncomeTypeConfig()
    private var billTypeConfig: Dictionary<String, String> {
        get {
            return isExpenditure ? expenditureConfig : incomeConfig
        }
    }
    private var billTypeArray: Array<BillTypeModel> {
        get {
            var array = Array<BillTypeModel>()
            for (iconName, title) in billTypeConfig {
                let model = BillTypeModel()
                model.iconName = iconName
                model.title = title
                array.append(model)
            }
            return array
        }
    }

    var body: some View {
        List {
            ForEach(billTypeArray) {model in
                Label(model.title, image: model.iconName)
                    .onTapGesture {
                        billTypeModel = model
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
        }
        .navigationBarTitle("选择账单类型")
    }
    
}
