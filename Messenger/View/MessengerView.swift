//
//  Messenger.swift
//  Messenger
//
//  Created by Nguyễn Thanh Sỹ on 18/05/2022.
//

import SwiftUI

struct MessengerView: View {
    @State var text = ""
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.self) var env
    var body: some View {
        BaseView(isNav: false, title: "", navigationBarHidden: true) {
            VStack(spacing: 0) {
                Group {
                    HStack {
                        Button {
                            env.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color("Color1"))
                                .frame(width: 27, height: 27)
                                .padding(.trailing, 10)
                        }
                        Image("imageAccount")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 45)
                            .clipShape(Circle())
                        VStack {
                            Text("Thanh Thanh")
                                .font(.system(size: 25))
                                .fontWeight(.semibold)
                                .padding(.top, 8)
                            Spacer(minLength: 0)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "phone.fill")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color("Color1"))
                                .frame(width: 28, height: 28)
                                .padding(.trailing, 12)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "video.fill")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color("Color1"))
                                .frame(width: 35, height: 35)
                        }
                        
                        
                    }
                    .frame(height: 65)
                    .padding(.horizontal)
                    
                }
                ScrollView(.vertical, showsIndicators: true) {
                    
                    VStack(alignment: .leading) {
                        MessageReceivedView(message: ContentMessage(id: UUID(), text: "A class is mutable, so when you change the rate inside the class, you still have the same instance.", timeStamp: Date(), from: 1, to: 2))
                        MessageReceivedView(message: ContentMessage(id: UUID(), text: "A class is mutable", timeStamp: Date(), from: 1, to: 2))
                        MessageSendView(message: ContentMessage(id: UUID(), text: "Oke.", timeStamp: Date(), from: 2, to: 1))
                        MessageSendView(message: ContentMessage(id: UUID(), text: "Thank you so much, i fix it right now", timeStamp: Date(), from: 2, to: 1))
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    
                }
                Group {
                    HStack(spacing: 16){
                        
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "photo")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color("Color1"))
                                .frame(width: 32, height: 32)
                        }
                        
                        
                        ZStack (alignment: .leading) {
                            TextField("", text: $text)
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .background(colorScheme == .dark ? .white.opacity(0.6) : .gray.opacity(0.1))
                                .clipShape(Capsule())
                            Text(text.isEmpty ? "Aa": "")
                                .font(.system(size: 20))
                                .foregroundColor(colorScheme == .dark ? .white : .gray)
                                .padding(.horizontal, 10)
                        }
                        .frame(maxWidth: .infinity)
                        
                        if !text.isEmpty {
                            Button {
                                
                            } label: {
                                Image(systemName: "paperplane.fill")
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color("Color1"))
                                    .frame(width: 32, height: 32)
                                    .rotationEffect(.degrees(45))
                            }
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
            }
        }
        
    }
}

struct MessengerView_Previews: PreviewProvider {
    static var previews: some View {
        MessengerView()
    }
}

struct MessageReceivedView: View {
    @Environment(\.colorScheme) var colorScheme
    var message: ContentMessage
    @State private var showTimeStamp = false
    var body: some View {
        HStack {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(message.text)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .fontWeight(.regular)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(colorScheme == .dark ? .white.opacity(0.82) : .gray.opacity(0.1))
                        .cornerRadius(15)
                        .onTapGesture {
                            showTimeStamp.toggle()
                        }
                    if showTimeStamp {
                        
                        Text( message.timeStamp.timeIn24HourFormat())
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                    }
                }
                Spacer(minLength: 0)
            }
            .frame(maxWidth: 320)
            Spacer()
        }
        .padding(.horizontal)
        
    }
}
struct MessageSendView: View {
    @Environment(\.colorScheme) var colorScheme
    var message: ContentMessage
    @State private var showTimeStamp = false
    var body: some View {
        HStack {
            Spacer()
            HStack {
                Spacer(minLength: 0)
                VStack(alignment: .leading, spacing: 2) {
                    Text(message.text)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .fontWeight(.regular)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background( Color("Color1"))
                        .cornerRadius(15)
                        .onTapGesture {
                            showTimeStamp.toggle()
                        }
                    if showTimeStamp {
                        
                        Text( message.timeStamp.timeIn24HourFormat())
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                    }
                }
                
            }
            .frame(maxWidth: 320)
            
        }
        .padding(.horizontal)
        
    }
}
struct ContentMessage: Identifiable {
    var id: UUID
    var text: String
    var timeStamp: Date
    var from: Int
    var to: Int
}


struct Account: Identifiable {
    var id: Int
    var name: String
    var image: UIImage
    var password: String
    var username: String
}
