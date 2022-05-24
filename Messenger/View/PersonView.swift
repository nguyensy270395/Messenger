//
//  PersonView.swift
//  Messenger
//
//  Created by Nguyễn Thanh Sỹ on 23/05/2022.
//

import SwiftUI

struct PersonView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.self) var env
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button {
                    env.dismiss()
                } label: {
                    Text("Xong")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                }
            }
            Image("imageAccount")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 125, height: 125)
                .clipShape(Circle())
            Text("Thanh Thanh")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("colorText"))
            
            VStack{
                HStack {
                    Image(systemName: viewModel.darkMode ? "moon.circle.fill" : "sun.max.circle.fill")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color("colorText"))
                    Text("Chế độ tối")
                        .font(.title3)
                        .foregroundColor(.primary)
                    Spacer()
                    
                    Toggle(isOn: $viewModel.darkMode) {
                    }
                    
                }
                .padding()
        
            }
            .background(viewModel.darkMode ? .white.opacity(0.3) : .white)
            .cornerRadius(20)
            .padding()
            Spacer()
        }
        .background(viewModel.darkMode ? .black.opacity(0.9) : .gray.opacity(0.1))
        .preferredColorScheme(viewModel.darkMode ? .dark : .light)
        
    }
}

