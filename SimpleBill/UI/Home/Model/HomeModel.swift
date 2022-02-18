//
//  HomeModel.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/17.
//

import Foundation

class TopMainCardViewCellModel {
    var name: String = ""
    var money: Double = 0.0
    var isHiddenMoney: Bool = false
}

class TopMainCardViewModel {
    var expenditure: Double = 0.0
    var income: Double = 0.0
    var isHiddenMoney: Bool = false
}
