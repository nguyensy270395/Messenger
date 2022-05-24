//
//  BaseView.swift
//  Messenger
//
//  Created by Nguyễn Thanh Sỹ on 24/05/2022.
//

import SwiftUI

struct BaseView<Content>: View where Content: View {
    @State var isNav: Bool = false
    @State var title: String = ""
    @State var navigationBarHidden: Bool = false
    @ViewBuilder let content: Content
    
    var body : some View {
        if isNav {
            NavigationView {
                wrapContent
            }
        } else {
            wrapContent
        }
    }
    
   private var wrapContent: some View {
        content
            .navigationTitle("\(title)")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(navigationBarHidden)
    }
}
