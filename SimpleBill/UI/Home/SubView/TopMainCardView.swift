//
//  TopMainCardView.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/13.
//

import Foundation
import SwiftUI

private struct TopMainCardViewCell: View {
    var model: TopMainCardViewCellModel
    @State private var hiddenMoney: Bool = false
    
    init(model: TopMainCardViewCellModel) {
        self.model = model
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 5
        ) {
            Text(model.name).font(.body).foregroundColor(Color.colorWithHexString(hexString: "#969696"))
            HStack {
                Text(hiddenMoney ? "******" : String(model.money)).font(.largeTitle).foregroundColor(Color.colorWithHexString(hexString: "#4B4B4B"))
                Spacer()
                Image(systemName: model.isHiddenMoney ? "eye.slash" : "eye")
                    .onTapGesture {
                        btnClick()
                    }
                    .foregroundColor(Color.colorWithHexString(hexString: "#969696"))
            }
        }
    }
    
    private func btnClick() {
        hiddenMoney = !hiddenMoney
    }
}

struct TopMainCardView: View {
    @State private var model: TopMainCardViewModel = TopMainCardViewModel()
    private var tempModel: TopMainCardViewModel = TopMainCardViewModel()
    private var expenditureModel: TopMainCardViewCellModel = TopMainCardViewCellModel()
    private var incomeModel: TopMainCardViewCellModel = TopMainCardViewCellModel()
    
    init(model: TopMainCardViewModel) {
        self.tempModel = model
        
        self.expenditureModel.name = "今日支出"
        self.expenditureModel.money = model.expenditure
        self.expenditureModel.isHiddenMoney = model.isHiddenMoney
        
        self.incomeModel.name = "今日收入"
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
