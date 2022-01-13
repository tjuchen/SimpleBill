//
//  SimpleBillApp.swift
//  SimpleBill
//
//  Created by chenyao on 2022/1/13.
//

import SwiftUI

@main
struct SimpleBillApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
