//
//  CalendarPanel.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/20.
//

import Foundation
import SwiftUI

struct CalendarPanel: View {
    @Binding var isPresent: Bool
    @Binding var selectedDate: Date
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                DatePicker("Please enter a date", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .background(BlurEffectView(style: .regular).onTapGesture(perform: {
                        isPresent = false
                    }))
            }
        }
    }
}

extension View {
    func calendarPanel(isPresent: Binding<Bool>, selectedDate: Binding<Date>) -> some View {
        ZStack {
            self
            isPresent.wrappedValue ? AnyView(CalendarPanel(isPresent: isPresent, selectedDate: selectedDate)) : AnyView(EmptyView())
        }
    }
}
