//
//  HomeView.swift
//  Messenger
//
//  Created by Nguyễn Thanh Sỹ on 19/05/2022.
//

import SwiftUI

struct HomeView: View {
    @State var search = ""
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    HStack {
                        Image("imageAccount")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .padding(.horizontal)
                        Spacer(minLength: 0)
                        
                    }
                    Text("Đoạn chat")
                        .font(.title)
                        .fontWeight(.semibold)
                        
                }
                ZStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 23, height: 23)
                            .foregroundColor(.black.opacity(0.5))
                            
                        Text("Tìm kiếm")
                            .font(.title2)
                            .fontWeight(.regular)
                            .foregroundColor(.black.opacity(0.5))
                        Spacer()
                        
                    }
                    .padding(.horizontal, 12)
                    TextField("", text: $search)
                        .padding(12)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(.gray.opacity(0.11))
                        .cornerRadius(13)
                }
                .padding(.top, 5)
                .padding(.horizontal)
            }
            .padding(.bottom)
           
            ScrollView(.vertical, showsIndicators: false) {
                
            }
            
            
            
            
            Spacer()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
