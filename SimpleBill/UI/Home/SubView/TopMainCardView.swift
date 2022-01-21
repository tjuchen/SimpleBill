//
//  TopMainCardView.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/13.
//

import Foundation
import SwiftUI

private struct TopMainCardViewCell: View {
    @State private var model: TopMainCardViewCellModel = TopMainCardViewCellModel()
    private var tempModel: TopMainCardViewCellModel = TopMainCardViewCellModel()
    @State private var moneyText: String = ""
    
    init(model: TopMainCardViewCellModel) {
        self.tempModel = model
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 5
        ) {
            Text(model.name).font(.body).foregroundColor(Color.colorWithHexString(hexString: "#969696"))
            HStack {
                Text(moneyText).font(.largeTitle).foregroundColor(Color.colorWithHexString(hexString: "#4B4B4B"))
                Spacer()
                Image(systemName: model.isHiddenMoney ? "eye.slash" : "eye").onTapGesture {
                    btnClick()
                }.foregroundColor(Color.colorWithHexString(hexString: "#969696"))
            }
        }.onAppear {
            model = tempModel
            moneyText = tempModel.isHiddenMoney ? "******" : String(tempModel.money)
        }
    }
    
    private func btnClick() {
        moneyText = model.isHiddenMoney ? String(model.money) : "******"
        model.isHiddenMoney = !model.isHiddenMoney
    }
}

struct TopMainCardView: View {
    @State private var model: TopMainCardViewModel = TopMainCardViewModel()
    private var tempModel: TopMainCardViewModel = TopMainCardViewModel()
    private var expenditureModel: TopMainCardViewCellModel = TopMainCardViewCellModel()
    private var incomeModel: TopMainCardViewCellModel = TopMainCardViewCellModel()
    
    static func namePrefix(type: BillDateType) -> String {
        switch type {
        case .BillDateType_Today:
            return "今日"
        case .BillDateType_AnotherDay:
            return "当日"
        case .BillDateType_SomeMonth:
            return "当月"
        case .BillDateType_SomeYear:
            return "当年"
        }
    }
    
    init(model: TopMainCardViewModel) {
        self.tempModel = model
        
        let namePrefix = TopMainCardView.namePrefix(type: model.showType)
        self.expenditureModel.name = namePrefix.appending("支出")
        self.expenditureModel.money = model.expenditure
        self.expenditureModel.isHiddenMoney = model.isHiddenMoney
        
        self.incomeModel.name = namePrefix.appending("收入")
        self.incomeModel.money = model.income
        self.incomeModel.isHiddenMoney = model.isHiddenMoney
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 25
        ) {
            TopMainCardViewCell(model: expenditureModel)
            TopMainCardViewCell(model: incomeModel)
        }.onAppear {
            model = tempModel
        }
    }
}
