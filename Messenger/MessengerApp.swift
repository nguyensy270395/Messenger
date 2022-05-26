//
//  MessengerApp.swift
//  Messenger
//
//  Created by Nguyễn Thanh Sỹ on 18/05/2022.
//

import SwiftUI
import Firebase


@main
struct MessengerApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    UIApplication.shared.hideKeyboardWhenTap()
                }
        }
    }
}

extension UIApplication {
    func hideKeyboardWhenTap() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}
