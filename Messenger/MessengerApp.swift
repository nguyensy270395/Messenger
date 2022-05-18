//
//  MessengerApp.swift
//  Messenger
//
//  Created by Nguyễn Thanh Sỹ on 18/05/2022.
//

import SwiftUI

@main
struct MessengerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
