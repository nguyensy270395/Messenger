//
//  HomeView.swift
//  Messenger
//
//  Created by Nguyễn Thanh Sỹ on 19/05/2022.
//

import SwiftUI
import UIKit

struct HomeView: View {
    @State var search = ""
    @State var index = 0
    @State var showPlaceholder = true
    
    var body: some View {
        
            VStack(spacing: 0) {
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
                        if showPlaceholder {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(.black.opacity(0.5))
                                    
                                Text("Tìm kiếm")
                                    .font(.system(size: 21))
                                    .fontWeight(.regular)
                                    .foregroundColor(.black.opacity(0.5))
                                Spacer()
                                
                            }
                            .padding(.horizontal, 12)
                        }
                       
                        TextField("", text: $search, onEditingChanged: { check in
                            showPlaceholder = !check
                        })
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
                    VStack(spacing: 16){
                        UserChatView()
                        UserChatView()
                        UserChatView()
                        UserChatView()
                        UserChatView()
                        UserChatView()
                        UserChatView()
                        UserChatView()
                        UserChatView()
                        UserChatView()
                    }
                    
                }
                HStack {
                    Spacer(minLength: 0)
                    VStack(spacing: 0) {
                        Image(systemName: "message")
                            .resizable()
                            .frame(width: 27, height: 27)
                            .foregroundColor(index == 0 ? Color("Color1") : .gray.opacity(0.9))
                            .padding(.vertical, 6)
                   
                        Text("Đoạn chat")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(index == 0 ? Color("Color1") : .gray.opacity(0.9))
                    }
                    .onTapGesture {
                        index = 0
                    }
                    Spacer(minLength: 0)
                    VStack(spacing: 0){
                        Image(systemName: "person.2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .foregroundColor(index == 1 ? Color("Color1") : .gray.opacity(0.9))
                            .padding(.top, 2)
                        Text("Danh bạ")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(index == 1 ? Color("Color1") : .gray.opacity(0.9))
                            .padding(.top, 3)
                    }
                    .onTapGesture {
                        index = 1
                    }
                    Spacer(minLength: 0)
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            
           
        }

        
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct UserChatView: View {
    var body: some View {
            HStack {
                Image("user")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 0){
                    Text("TPBank")
                        .font(.system(size: 22))
                        .fontWeight(.medium)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Text("Message: Hello")
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .foregroundColor(.black.opacity(0.7))
                }
                
            }
            .padding(.horizontal)
        }
    
}
