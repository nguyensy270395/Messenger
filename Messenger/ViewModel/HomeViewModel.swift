//
//  HomeViewModel.swift
//  Messenger
//
//  Created by Nguyễn Thanh Sỹ on 23/05/2022.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var darkMode = false {
        didSet {
            KEYWINDOW!.rootViewController?.overrideUserInterfaceStyle = darkMode ? .dark : .light
            print(KEYWINDOW!.rootViewController?.overrideUserInterfaceStyle)
            print(Color.primary)
        }
    }
    @Environment(\.colorScheme) var scheme
}
