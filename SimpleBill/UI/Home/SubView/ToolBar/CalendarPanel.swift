//
//  CalendarPanel.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/20.
//

import Foundation
import SwiftUI

struct CalendarPanel: View {
    @State private var wakeUp = Date()
    
    var body: some View {
        DatePicker("Please enter a date", selection: $wakeUp)
    }
}
//
//extension View {
//    func (<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
//}
